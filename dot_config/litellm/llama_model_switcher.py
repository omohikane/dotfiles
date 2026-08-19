from __future__ import annotations

import asyncio
import logging
import os
import time
import urllib.error
import urllib.request
from pathlib import Path
from typing import Literal

from fastapi import HTTPException
from litellm.integrations.custom_logger import CustomLogger
from litellm.proxy.proxy_server import DualCache, UserAPIKeyAuth

logger = logging.getLogger("llama_model_switcher")


class LlamaModelSwitcher(CustomLogger):
    """
    LiteLLMで指定されたモデル名に応じてactive.envを切り替え、
    llama-server@active.serviceを再起動する。
    """

    # LiteLLM上のモデル名 -> envファイル名
    MODEL_MAP = {
        "rx6800-qw-base": "qwen36-base.env",
        "rx6800-mero": "g4-meromero.env",
        "rx6800-qwen38": "qwen38-27b.env",
        "rx6800-qwen38-xhigh": "qwen38-27b-xhigh.env",
    }

    def __init__(self) -> None:
        super().__init__()

        self.config_dir = Path.home() / ".config" / "llama-server"
        self.active_env = self.config_dir / "active.env"
        self.service_name = "llama-server@active.service"
        self.health_url = "http://127.0.0.1:11435/health"

        self.switch_timeout = 180.0
        self.health_interval = 1.0

        # 同時に複数の切替処理が走らないようにする
        self._switch_lock = asyncio.Lock()

        logger.info("LlamaModelSwitcher initialized")

    async def async_pre_call_hook(
        self,
        user_api_key_dict: UserAPIKeyAuth,
        cache: DualCache,
        data: dict,
        call_type: Literal[
            "completion",
            "text_completion",
            "embeddings",
            "image_generation",
            "moderation",
            "audio_transcription",
        ],
    ) -> dict:
        requested_model = data.get("model")

        env_filename = self.MODEL_MAP.get(requested_model)

        # CloudモデルやMeigaoなどは何もせず通す
        if env_filename is None:
            return data

        target_env = self.config_dir / env_filename

        if not target_env.is_file():
            logger.error("Environment file does not exist: %s", target_env)
            raise HTTPException(
                status_code=503,
                detail=f"llama-server env file not found: {target_env}",
            )

        async with self._switch_lock:
            if self._is_selected(target_env):
                if await asyncio.to_thread(self._health_ok):
                    logger.info(
                        "Model already selected and healthy: %s",
                        requested_model,
                    )
                    return data

                logger.warning(
                    "Correct model selected but backend is unhealthy: %s",
                    requested_model,
                )
            else:
                logger.info(
                    "Switching llama-server: %s -> %s",
                    requested_model,
                    target_env.name,
                )

                await asyncio.to_thread(
                    self._replace_active_symlink,
                    target_env,
                )

            await self._restart_llama_server()
            await self._wait_for_health()

            logger.info(
                "llama-server is ready: model=%s env=%s",
                requested_model,
                target_env.name,
            )

        return data

    def _is_selected(self, target_env: Path) -> bool:
        try:
            return self.active_env.resolve(strict=True) == target_env.resolve(
                strict=True
            )
        except (FileNotFoundError, OSError):
            return False

    def _replace_active_symlink(self, target_env: Path) -> None:
        """
        active.envを新しいenvへのシンボリックリンクに置き換える。
        os.replace()により途中状態をなるべく見せない。
        """
        temporary_link = self.config_dir / (f".active.env.{os.getpid()}.tmp")

        try:
            temporary_link.unlink(missing_ok=True)
            temporary_link.symlink_to(target_env)
            os.replace(temporary_link, self.active_env)
        finally:
            temporary_link.unlink(missing_ok=True)

    async def _restart_llama_server(self) -> None:
        process = await asyncio.create_subprocess_exec(
            "systemctl",
            "--user",
            "restart",
            self.service_name,
            stdout=asyncio.subprocess.PIPE,
            stderr=asyncio.subprocess.PIPE,
        )

        stdout, stderr = await process.communicate()

        if process.returncode == 0:
            return

        stdout_text = stdout.decode(errors="replace").strip()
        stderr_text = stderr.decode(errors="replace").strip()

        logger.error(
            "systemctl restart failed: stdout=%s stderr=%s",
            stdout_text,
            stderr_text,
        )

        raise HTTPException(
            status_code=503,
            detail=(f"Failed to restart llama-server: {stderr_text or stdout_text}"),
        )

    async def _wait_for_health(self) -> None:
        deadline = time.monotonic() + self.switch_timeout

        while time.monotonic() < deadline:
            if await asyncio.to_thread(self._health_ok):
                return

            await asyncio.sleep(self.health_interval)

        raise HTTPException(
            status_code=503,
            detail=(
                "llama-server did not become healthy within "
                f"{self.switch_timeout:.0f} seconds"
            ),
        )

    def _health_ok(self) -> bool:
        try:
            with urllib.request.urlopen(
                self.health_url,
                timeout=2.0,
            ) as response:
                return 200 <= response.status < 300
        except (
            urllib.error.URLError,
            TimeoutError,
            ConnectionError,
        ):
            return False


llama_model_switcher = LlamaModelSwitcher()
