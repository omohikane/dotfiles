#!/usr/bin/env bash
STATE="$HOME/.local/state/llama-server"
mkdir -p "$STATE"

systemctl --user list-units 'llama-server@*' --state=active --no-legend |
  awk '{print $1}' >"$STATE/active"

while read -r unit; do
  [[ -n "$unit" ]] && systemctl --user stop "$unit"
done <"$STATE/active"
