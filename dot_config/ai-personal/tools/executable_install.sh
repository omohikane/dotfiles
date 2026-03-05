#!/usr/bin/env bash
set -euo pipefail

ROOT="${HOME}/.config/ai-personal"
MAP="${ROOT}/tools/install-map.tsv"

MODE="link" # link | copy
DRY_RUN=0

usage() {
  cat <<'USAGE'
Usage: install.sh [--link|--copy] [--dry-run]

Installs ai-personal client dotfiles into their tool-specific locations.
- --link (default): create symlinks
- --copy: copy files
- --dry-run: print actions only
USAGE
}

while [[ $# -gt 0 ]]; do
  case "$1" in
  --link)
    MODE="link"
    shift
    ;;
  --copy)
    MODE="copy"
    shift
    ;;
  --dry-run)
    DRY_RUN=1
    shift
    ;;
  -h | --help)
    usage
    exit 0
    ;;
  *)
    echo "Unknown arg: $1" >&2
    usage
    exit 1
    ;;
  esac
done

[[ -f "$MAP" ]] || {
  echo "Map not found: $MAP" >&2
  exit 1
}

ts() { date +"%Y%m%d-%H%M%S"; }

do_cmd() {
  if [[ "$DRY_RUN" -eq 1 ]]; then
    echo "[dry-run] $*"
  else
    eval "$@"
  fi
}

expand_vars() {
  # expand $HOME in TSV dest column safely
  local s="$1"
  s="${s//\$HOME/${HOME}}"
  echo "$s"
}

while IFS=$'\t' read -r tool src_rel dest_raw; do
  [[ -z "${tool}" || "${tool:0:1}" == "#" ]] && continue

  src="${ROOT}/${src_rel}"
  dest="$(expand_vars "$dest_raw")"

  if [[ ! -f "$src" ]]; then
    echo "Skip (missing src): $src" >&2
    continue
  fi

  dest_dir="$(dirname "$dest")"
  do_cmd "mkdir -p \"${dest_dir}\""

  if [[ -e "$dest" || -L "$dest" ]]; then
    backup="${dest}.bak.$(ts)"
    do_cmd "mv \"${dest}\" \"${backup}\""
    echo "Backed up: ${dest} -> ${backup}"
  fi

  if [[ "$MODE" == "link" ]]; then
  do_cmd "ln -sfn \"${src}\" \"${dest}\""
  if [[ "$DRY_RUN" -ne 1 ]]; then
    echo "Linked: ${dest} -> ${src}"
  else
    echo "[dry-run] link: ${dest} -> ${src}"
  fi
else
  do_cmd "cp -a \"${src}\" \"${dest}\""
  if [[ "$DRY_RUN" -ne 1 ]]; then
    echo "Copied: ${src} -> ${dest}"
  else
    echo "[dry-run] copy: ${src} -> ${dest}"
  fi
fi

done <"$MAP"
