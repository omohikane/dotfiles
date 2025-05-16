#!/usr/bin/env bash

VPN_IFS=$(ip link show | grep -Eo 'wg[0-9a-zA-Z_-]*|gw[0-9a-zA-Z_-]*' | sort | uniq)

if [[ -n "$VPN_IFS" ]]; then
  echo "{\"text\": \"🔒 VPN\", \"tooltip\": \"Connected via: $VPN_IFS\"}"
else
  echo "{\"text\": \"🔓\", \"tooltip\": \"No VPN interface active\"}"
fi

