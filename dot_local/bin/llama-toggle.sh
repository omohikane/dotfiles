#!/usr/bin/env bash
UNIT='llama-server@qwen3-30b'
if systemctl --user is-active --quiet "$UNIT"; then
  systemctl --user stop "$UNIT"
  notify-send "llama-server" "stopped"
else
  systemctl --user start "$UNIT"
  notify-send "llama-server" "started"
fi
