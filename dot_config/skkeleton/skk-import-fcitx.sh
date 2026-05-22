#!/usr/bin/env bash
set -euo pipefail

FCITX_DICT="$HOME/.local/share/fcitx5/skk/user.dict"
SKEL_DICT="$HOME/.config/skkeleton/SKK-JISYO.user"

TMP="$(mktemp)"

[[ -f "$FCITX_DICT" ]] || exit 0

# EUC-JP → UTF-8
iconv -f EUC-JP -t UTF-8 "$FCITX_DICT" > "$TMP" 2>/dev/null || exit 0

# マージ（シンプル版）
{
  echo ";;; -*- coding: utf-8 -*-"
  echo ";; merged entries"

  cat "$SKEL_DICT" 2>/dev/null || true
  cat "$TMP"
} \
| grep -v '^;;' \
| sed '/^$/d' \
| sort \
| uniq \
> "${SKEL_DICT}.merged"

mv "${SKEL_DICT}.merged" "$SKEL_DICT"
rm -f "$TMP"

echo "[DONE]"
