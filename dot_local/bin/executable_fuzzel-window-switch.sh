#!/bin/bash
# sway window switcher via fuzzel (Wayland-native).
# Lists all windows, focuses the selected one.
set -u

entries="$(python3 <<'PYEOF'
import json, subprocess

raw = subprocess.run(["swaymsg", "-t", "get_tree"],
                     capture_output=True, text=True).stdout

def walk(node, ws, out):
    if node.get("type") == "workspace":
        ws = node.get("name", ws)
    if node.get("type") in ("con", "floating_con") and node.get("name") and node.get("id"):
        app = node.get("app_id") or (node.get("window_properties") or {}).get("class") or "?"
        out.append(f'{node["id"]}\t[{ws}] {app} — {node["name"]}')
    for child in node.get("nodes", []) + node.get("floating_nodes", []):
        walk(child, ws, out)

tree = json.loads(raw)
items = []
walk(tree, "", items)
print("\n".join(items))
PYEOF
)"
[ -z "${entries:-}" ] && exit 0

list="$(printf '%s\n' "$entries" | cut -f2-)"
choice="$(printf '%s\n' "$list" | fuzzel --dmenu --prompt 'window: ')" || exit 0
[ -z "${choice:-}" ] && exit 0

n="$(printf '%s\n' "$list" | grep -n -x -F "$choice" | head -1 | cut -d: -f1)"
[ -z "${n:-}" ] && exit 0
id="$(printf '%s\n' "$entries" | sed -n "${n}p" | cut -f1)"
swaymsg "[con_id=${id}] focus" >/dev/null
