#!/usr/bin/env bash
set -euo pipefail

SRC="$HOME/.local/src/llama.cpp"
cd "$SRC"

git fetch --tags --quiet
OLD=$(git rev-parse HEAD)
git pull --ff-only --quiet
NEW=$(git rev-parse HEAD)

if [[ "$OLD" == "$NEW" ]]; then
  exit 0
fi

if ! cmake -B build-latest -DGGML_VULKAN=ON -DCMAKE_BUILD_TYPE=Release >/dev/null; then
  notify-send -u critical "llama.cpp" "cmake configure failed"
  exit 1
fi

if ! cmake --build build-latest -j"$(nproc)" >/dev/null; then
  notify-send -u critical "llama.cpp" "build failed at $NEW"
  exit 1
fi

LOG=$(git log --oneline "$OLD..$NEW" | head -5)
notify-send "llama.cpp updated" "$LOG"
