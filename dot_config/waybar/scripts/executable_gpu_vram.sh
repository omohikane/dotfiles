#!/bin/bash
# AMD GPU のVRAM使用率をsysfsから取得してwaybar表示。
set -u

used=0
total=1
for f in /sys/class/drm/card*/device/mem_info_vram_used; do
    if [ -r "$f" ]; then
        used="$(cat "$f")"
        total="$(cat "${f%_used}_total")"
        break
    fi
done

pct=$((used * 100 / total))
echo "{\"text\": \" GPU ${pct}%\", \"tooltip\": \"VRAM $((used / 1024 / 1024)) / $((total / 1024 / 1024)) MiB (${pct}%)\"}"
