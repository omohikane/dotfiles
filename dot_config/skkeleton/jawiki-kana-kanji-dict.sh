#!/usr/bin/env bash
set -e

BASE="$HOME/.config/skkeleton/dicts"
TMP="$(mktemp -d)"

mkdir -p "$BASE"

echo "[FETCH] jawiki latest release..."

url=$(curl -s https://api.github.com/repos/tokuhirom/jawiki-kana-kanji-dict/releases/latest \
  | jq -r '.assets[].browser_download_url' \
  | grep -E 'utf8|dict|skk' \
  | head -1)

if [ -z "$url" ]; then
    echo "[ERROR] download url not found"
    exit 1
fi

curl -L "$url" -o "$TMP/dict"

echo "[INSTALL]"

mv "$TMP/dict" "$BASE/SKK-JISYO.wiki.utf8"

rm -rf "$TMP"

echo "[DONE]"
