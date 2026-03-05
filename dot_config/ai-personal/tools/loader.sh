#!/bin/bash
# ~/.config/ai-personal/loader.sh
# 使い方: aider --message "$(~/.config/ai-personal/loader.sh security-specialist) このコードをレビューして"

CONFIG_DIR="$HOME/.config/ai-personal"
ROLE=$1

# 1. 共通コンテキストを結合
cat "$CONFIG_DIR/common/working-style.md"
cat "$CONFIG_DIR/common/brand-voice.md"
cat "$CONFIG_DIR/_MANIFEST.md"

# 2. 指定されたロールがあれば追加 (パスを自動探索)
if [ -n "$ROLE" ]; then
    FILE=$(find "$CONFIG_DIR/personas" "$CONFIG_DIR/skills" -name "$ROLE.md" | head -n 1)
    if [ -f "$FILE" ]; then
        cat "$FILE"
    fi
fi
