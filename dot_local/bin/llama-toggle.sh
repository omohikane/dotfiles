#!/usr/bin/env bash
# llama-toggle: llama-server@active の起動/停止を切り替える（旧 unit 名を修正）
set -euo pipefail
UNIT='llama-server@active.service'
if systemctl --user is-active --quiet "$UNIT"; then
  systemctl --user stop "$UNIT"
  command -v notify-send >/dev/null && notify-send "llama-server" "stopped"
  echo "stopped"
else
  systemctl --user start "$UNIT"
  command -v notify-send >/dev/null && notify-send "llama-server" "started ($(readlink -f "$HOME/.config/llama-server/active.env" | xargs basename | sed 's/\.env$//'))"
  echo "started"
fi
