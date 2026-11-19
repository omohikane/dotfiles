# r1ppl3 ホーム運用ルール

## 作業方針

- AI 関連の生成物・レポート・手順書は `~/ai-workspace/` 配下に置く
  - `reports/`: レポート（モデル評価・調査結果など）
  - `setup-docs/`: セットアップ手順書
  - `output/`: その他生成物（`todo.md`、計測スクリプト、`eval/` など）
- ホーム直下にファイルを追加しない（重要）
- このファイルは「ホーム（`~`）で opencode を実行したとき」の追加ルール。グローバル既定は `~/.config/opencode/AGENTS.md`
- 長命プロセス（dev サーバ・テスト・ビルド）は `background` を明示して起動し、停止手順（PID / ポート / systemctl）を併記する
- opencode 2.3.2 以降、タイムアウトしたコマンドは kill されずバックグラウンドで継続する。`timeout` を停止手段として使わず、明示的に停止する

## 環境メモ

- マシン: `Endeavour-Desktop-Ryzen` / GPU: **RX 7900 XTX**（ROCm / HIP）
- ローカル LLM: `~/.config/llama-server/active.env` のシンボリックリンクを差し替えて切替
  （litellm :4000 → llama-server :11435）
  - 現在の既定: `qwen38-27b.env`（Qwen3.8-27B IQ4_XS / CTX=131072 / `--spec-type draft-mtp` の MTP 投機的デコードで decode 60 tok/s 前後）
  - 予備: `g4-meromero.env`（会話用）, `ornith-hip.env`（高速 MoE 枠）, `orca-cyber.env`, `qwen38-unc-iq4.env`
  - 一括評価用: `eval-*.env`（`~/ai-workspace/output/eval/batch_runner.py` が生成）
- litellm のローカルモデル名は **`rx7900-*`**（`rx6800-*` は廃止）。サービスは `systemctl --user` で稼働
- opencode のデフォルトモデル: `opencode-go/deepseek-v4.1-flash`（OpenCode Go 契約・クラウド）。ローカルは `litellm/rx7900-*`（`~/.config/opencode/opencode.json`）
- DeepSeek 直プロバイダ（`deepseek`）は残高なし。`enabled_providers` で除外中（`opencode-go` / `litellm` / `plamo` / `opencode` のみ有効）
- Zen（`opencode`）の無料モデルは GitHub 連携要件で弾かれる場合あり
- LLM 評価レポート: `~/ai-workspace/reports/`（最新: `model-selection-2026-10-25.md`, `mtp-swap-in-rx7900xtx.md`）

## GitHub リポジトリ

- Obsidian ノート: `~/Github/r1ppl3s-obsidian-notes/`
  - Zenn 記事: `03_Projects/Blogs/Zenn/Published/`（published）と `Draft/`（下書き）
- Zenn 公開用リポジトリ: `~/Github/zenn-blog/`（`articles/` `books/` `scraps/`）
- その他: `~/Github/` 配下（`saku` `AetherLog` `agentic-coding-benchmark` `ai-agentos-bootstrap` `asari` `r1ppl3-noc` `UnityMCP-VRC`）

## ドットファイル

- **chezmoi** 管理（source: `~/.local/share/chezmoi`、remote: `omohikane/dotfiles`）
- `~/Github/dotfiles/` はもう存在しない
- `~/.config/llama-server/*.env`、`~/.config/litellm/`、`~/.config/opencode/AGENTS.md` は chezmoi 管理
  → 直接編集せず `chezmoi edit` / `chezmoi add` を使う

## その他

- SSH: `~/.ssh/conf.d/`（`personal.conf` / `work.conf`）にホスト定義
  （`Fuchu-LLM-Server`, `AI-AgentOS`, `Proxmox-01`〜`03` など）
