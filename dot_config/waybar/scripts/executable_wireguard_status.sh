#!/bin/bash

if ip link show wg0 > /dev/null 2>&1; then
  echo "{\"text\": \"🔒 wg0\", \"tooltip\": \"WireGuard active (wg0)\"}"
else
  echo "{\"text\": \"\", \"tooltip\": \"WireGuard not active\"}"
fi

