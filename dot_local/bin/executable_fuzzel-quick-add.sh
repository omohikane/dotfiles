#!/bin/bash
# fuzzel quick-add: 1行入力→00_Inbox/scrap.mdに時刻付き追記。エディタを開かない。
# 使い方: fuzzel-quick-add.sh (引数なし。fuzzelの入力欄に書いてEnter)
set -u

SCRAP="${HOME}/Github/r1ppl3s-obsidian-notes/00_Inbox/scrap.md"

text="$(printf '' | fuzzel --dmenu --prompt 'scrap: ')" || exit 0
[ -z "${text:-}" ] && exit 0

if [ ! -f "$SCRAP" ]; then
    printf '# scrap\n\n' > "$SCRAP"
fi
printf -- '- %s %s\n' "$(date '+%m-%d %H:%M')" "$text" >> "$SCRAP"
notify-send "scrap" "追記しました"
