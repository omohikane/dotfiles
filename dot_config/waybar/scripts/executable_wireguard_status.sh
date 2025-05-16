#!/bin/bash

target_prefixes=("wg" "gw")

active_vpn=()

for iface in $(ip link show | awk -F: '/^[0-9]+: / {print $2}' | tr -d ' '); do
  for prefix in "${target_prefixes[@]}"; do
    if [[ "$iface" == "$prefix"* ]]; then
      if wg show "$iface" > /dev/null 2>&1; then
        active_vpn+=("$iface")
      fi
    fi
  done
done

if [ ${#active_vpn[@]} -gt 0 ]; then
  text="🔒 ${active_vpn[*]}"
  tooltip="WireGuard active: ${active_vpn[*]}"
fi

echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\"}"

