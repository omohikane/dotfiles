#!/bin/bash
# sway combi launcher (rofi -show combi 風)。
# Alt+Space 一発で window / app / web検索 / file検索 / emoji / clipboard履歴 / snippet を選ぶ。アイコン付き。
# window → focus、app → 起動(起動中は除外)、emoji/clip/snip → 貼付け(wtype) or コピー。
set -u

SNIPDIR="${HOME}/.config/snippets"
export EMOJIFILE="${HOME}/.config/fuzzel/emoji.txt"
SEARCH_DIRS=("$HOME/Projects" "$HOME/Documents" "$HOME/Downloads")

choice="$(python3 <<'PYEOF' | fuzzel --dmenu --prompt 'launch: ' --with-nth=1 --accept-nth=2
import json, subprocess, os, configparser

tree = json.loads(subprocess.run(
    ["swaymsg", "-t", "get_tree"],
    capture_output=True, text=True).stdout)

wins = []
def walk(node, ws):
    if node.get("type") == "workspace":
        ws = node.get("name", ws)
    if node.get("type") in ("con", "floating_con") and node.get("name") and node.get("id"):
        app = node.get("app_id") or (node.get("window_properties") or {}).get("class") or "?"
        wins.append({"id": node["id"], "ws": ws, "app": app, "title": node["name"]})
    for c in node.get("nodes", []) + node.get("floating_nodes", []):
        walk(c, ws)
walk(tree, "")

running = {w["app"].lower() for w in wins}

def match_key(keys):
    for k in keys:
        if not k or len(k) < 3:
            continue
        for r in running:
            if k == r or k in r or r in k:
                return True
    return False

desktops = []
seen = set()
for d in (os.path.expanduser("~/.local/share/applications"), "/usr/share/applications"):
    if not os.path.isdir(d):
        continue
    for f in sorted(os.listdir(d)):
        if not f.endswith(".desktop"):
            continue
        cp = configparser.ConfigParser(interpolation=None)
        cp.optionxform = str
        try:
            cp.read(os.path.join(d, f), encoding="utf-8")
            e = cp["Desktop Entry"]
        except Exception:
            continue
        # NoDisplay/Hidden は一覧に出さないがアイコン解決用に登録する
        if e.get("Type", "Application") != "Application":
            continue
        name = e.get("Name", f)
        if not name or name in seen:
            continue
        seen.add(name)
        keys = set()
        if e.get("StartupWMClass"):
            keys.add(e["StartupWMClass"].lower())
        exe = e.get("Exec", "").split()
        if exe:
            keys.add(os.path.basename(exe[0]).lower())
        # アイコン解決用には NoDisplay/Hidden も登録する(一覧には出さない)
        hidden = (e.get("NoDisplay", "false").lower() == "true"
                  or e.get("Hidden", "false").lower() == "true")
        desktops.append({"desk": f, "name": name, "keys": keys,
                         "icon": e.get("Icon", ""), "hidden": hidden,
                         "term": e.get("Terminal", "false").lower() == "true",
                         "exec": e.get("Exec", "")})

def icon_for(keys, default):
    for dt in desktops:
        if keys & dt["keys"]:
            if dt["icon"]:
                return dt["icon"]
    for dt in desktops:
        for k in keys:
            if not k or len(k) < 3:
                continue
            for dk in dt["keys"]:
                if k == dk or k in dk or dk in k:
                    if dt["icon"]:
                        return dt["icon"]
    return default

def clean(s):
    return (s or "").replace("\t", " ").replace("\n", " ").replace("\x1f", " ")

def emit(display, kind, payload, icon):
    print(f'{clean(display)}\t{kind}\x1f{payload}\0icon\x1f{icon}')

for w in wins:
    wkeys = {w["app"].lower()}
    emit(f'[win] [{w["ws"]}] {w["app"]} — {w["title"]}',
         "W", str(w["id"]), icon_for(wkeys, "application-x-executable"))
for a in (d for d in desktops if not d["hidden"] and not match_key(d["keys"])):
    exe = " ".join(a["exec"].split())
    emit(f'[app] {a["name"]}', "A",
         f'{a["desk"]}\x1f{a["term"]}\x1f{exe}',
         a["icon"] or "application-x-executable")

try:
    out = subprocess.run(["cliphist", "list"], capture_output=True, text=True, timeout=5).stdout
    for line in out.splitlines():
        parts = line.split("\t", 1)
        if len(parts) == 2:
            emit(f'[clip] {parts[1][:100]}', "C", parts[0], "edit-paste")
except Exception:
    pass

snipdir = os.path.expanduser("~/.config/snippets")
if os.path.isdir(snipdir):
    for f in sorted(os.listdir(snipdir)):
        if f.endswith(".txt"):
            emit(f'[snip] {f[:-4]}', "S", f[:-4], "text-x-generic")

emit('[web] Web検索...', "B", "web", "web-browser")
emit('[file] ファイル検索...', "F", "file", "system-file-manager")

emojifile = os.path.expanduser(os.environ.get("EMOJIFILE", "~/.config/fuzzel/emoji.txt"))
try:
    with open(emojifile, encoding="utf-8") as fh:
        for line in fh:
            line = line.strip()
            if not line or line.startswith("#"):
                continue
            parts = line.split(None, 1)
            char = parts[0]
            kw = parts[1] if len(parts) > 1 else char
            emit(f'[emoji] {char} {kw}', "E", char, "face-smile")
except FileNotFoundError:
    pass
PYEOF
)" || exit 0
[ -z "${choice:-}" ] && exit 0

# choice は「種別\x1fペイロード」(単一列受け・アイコン指定は fuzzel が除去済み)
printf '--- %s ---\n' "$(date +%T)" >> /tmp/combi-debug.log
printf '%s' "$choice" | cat -v >> /tmp/combi-debug.log
printf '\n' >> /tmp/combi-debug.log
kind="${choice%%$'\037'*}"
rest="${choice#*$'\037'}"

paste_or_copy() {
    printf '%s' "$1" | wl-copy
    if command -v wtype >/dev/null 2>&1; then
        sleep 0.2
        wtype -M ctrl v -m ctrl 2>/dev/null || true
    else
        notify-send "combi" "コピーしました(Ctrl+Vで貼付け)"
    fi
}

case "$kind" in
    W)
        swaymsg "[con_id=${rest}] focus" >/dev/null
        ;;
    A)
        IFS=$'\037' read -r desk term exe <<< "$rest"
        if [ "$term" = "True" ]; then
            cmd="$(printf '%s' "$exe" | sed -E 's/ *%[fFuUick]//g')"
            # shellcheck disable=SC2086
            swaymsg exec -- alacritty -e $cmd >/dev/null
        else
            swaymsg exec -- gtk-launch "$desk" >/dev/null
        fi
        ;;
    C)
        text="$(cliphist decode "$rest")"
        [ -n "${text:-}" ] && paste_or_copy "$text"
        ;;
    S)
        f="${SNIPDIR}/${rest}.txt"
        [ -f "$f" ] && paste_or_copy "$(cat "$f")"
        ;;
    E)
        [ -n "${rest:-}" ] && paste_or_copy "$rest"
        ;;
    B)
        q="$(printf '' | fuzzel --dmenu --prompt 'web: ')" || exit 0
        [ -z "${q:-}" ] && exit 0
        case "$q" in
            http://*|https://*) url="$q" ;;
            *) enc="$(printf '%s' "$q" | python3 -c 'import sys,urllib.parse; print(urllib.parse.quote(sys.stdin.read().strip()))')"
               url="https://www.google.com/search?q=${enc}" ;;
        esac
        swaymsg exec -- xdg-open "$url" >/dev/null
        ;;
    F)
        list="$(for d in "${SEARCH_DIRS[@]}"; do
            [ -d "$d" ] || continue
            fd --type f --hidden --exclude .git --exclude node_modules --exclude __pycache__ . "$d" 2>/dev/null
        done)"
        [ -z "${list:-}" ] && { notify-send "combi" "ファイルが見つかりません"; exit 0; }
        sel="$(printf '%s\n' "$list" | fuzzel --dmenu --prompt 'file: ')" || exit 0
        [ -z "${sel:-}" ] && exit 0
        swaymsg exec -- xdg-open "$sel" >/dev/null
        ;;
esac
