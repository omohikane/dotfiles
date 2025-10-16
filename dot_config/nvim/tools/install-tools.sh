#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PACMAN_LIST="${ROOT}/pacman.txt"
AUR_LIST="${ROOT}/aur.txt"

have() { command -v "$1" >/dev/null 2>&1; }

install_pacman() {
  [[ -f "$PACMAN_LIST" ]] || return 0
  mapfile -t pkgs < <(grep -v '^\s*#' "$PACMAN_LIST" | sed '/^\s*$/d')
  [[ ${#pkgs[@]} -eq 0 ]] && return 0
  echo "==> pacman: ${pkgs[*]}"
  sudo pacman -Syu --needed --noconfirm "${pkgs[@]}"
}

install_aur() {
  [[ -f "$AUR_LIST" ]] || return 0
  local helper=""
  if have yay; then
    helper="yay"
  elif have paru; then
    helper="paru"
  fi
  [[ -z "$helper" ]] && {
    echo "AUR helper (yay/paru) not found. Skip AUR."
    return 0
  }
  mapfile -t pkgs < <(grep -v '^\s*#' "$AUR_LIST" | sed '/^\s*$/d')
  [[ ${#pkgs[@]} -eq 0 ]] && return 0
  echo "==> ${helper}: ${pkgs[*]}"
  "$helper" -S --needed --noconfirm "${pkgs[@]}"
}

install_pacman
install_aur
echo "All done."
