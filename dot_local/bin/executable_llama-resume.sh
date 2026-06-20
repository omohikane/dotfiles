#!/usr/bin/env bash
STATE="$HOME/.local/state/llama-server"
[[ -f "$STATE/active" ]] || exit 0

while read -r unit; do
  [[ -n "$unit" ]] && systemctl --user start "$unit"
done <"$STATE/active"
