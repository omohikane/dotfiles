#!/usr/bin/env bash
set -euo pipefail

# termux/setup.sh - minimal SSH-client setup for Termux (razr 50 + Clicks)
# Usage (on Termux): pkg update -y && pkg install -y git openssh; git clone https://github.com/omohikane/dotfiles.git ~/dotfiles; cd ~/dotfiles/termux && bash setup.sh
# 補足: リモート開発用SSHクライアントとして使うだけなので、fish/zellij等は入れない

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
if [[ ! -d "$DOTFILES_DIR/termux" ]]; then
  DOTFILES_DIR="$HOME/dotfiles"
fi

echo "==> Dotfiles dir: $DOTFILES_DIR"

if command -v pkg >/dev/null 2>&1; then
  echo "==> Installing essentials (git + openssh + mosh)..."
  # 最小構成: git, openssh, mosh(任意だが切断対策で推奨)。fish/zellijは不要
  pkg update -y && pkg upgrade -y
  pkg install -y git openssh mosh || pkg install -y git openssh
else
  echo "[WARN] pkg not found - not on Termux? Skipping pkg install."
fi

echo "==> Setting up Termux properties..."
mkdir -p ~/.termux
if [[ -f "$DOTFILES_DIR/termux/termux.properties" ]]; then
  ln -sf "$DOTFILES_DIR/termux/termux.properties" ~/.termux/termux.properties
  echo "  linked termux.properties"
fi
if command -v termux-reload-settings >/dev/null 2>&1; then
  termux-reload-settings || true
fi

echo "==> Setting up SSH (Termux -> Home)..."
mkdir -p ~/.ssh && chmod 700 ~/.ssh
if [[ ! -f ~/.ssh/id_ed25519 ]]; then
  echo "  No ~/.ssh/id_ed25519 found. Generating..."
  ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N "" -C "termux-razr50-$(date +%Y%m%d)"
  echo "  Generated. Copy this to home server authorized_keys:"
  echo "  ---"
  cat ~/.ssh/id_ed25519.pub
  echo "  ---"
else
  echo "  Existing key: ~/.ssh/id_ed25519 (skip)"
fi

if [[ ! -f ~/.ssh/config ]] && [[ -f "$DOTFILES_DIR/termux/ssh-config.example" ]]; then
  cp "$DOTFILES_DIR/termux/ssh-config.example" ~/.ssh/config
  chmod 600 ~/.ssh/config
  echo "  installed ssh config -> ~/.ssh/config"
elif [[ -f "$DOTFILES_DIR/termux/ssh-config.example" ]]; then
  echo "  [INFO] ~/.ssh/config exists. Compare with $DOTFILES_DIR/termux/ssh-config.example"
fi

# shell aliases (bash/zsh) - fish不要でも使える
if [[ -f "$DOTFILES_DIR/termux/aliases.sh" ]]; then
  echo "  [INFO] To enable hs/hsp aliases, add to ~/.bashrc:"
  echo "        source ~/dotfiles/termux/aliases.sh"
fi

echo ""
echo "Done! Next:"
echo "  1. NetBird Androidアプリを接続"
echo "  2. cat ~/.ssh/id_ed25519.pub を自宅PCの ~/.ssh/authorized_keys に追記"
echo "  3. ssh endeavour  # or ssh r1ppl3@endeavour-desktop-ryzen.netbird.cloud"
echo "  4. ssh -t endeavour 'zellij --layout phone attach -c phone'  # スマホ用レイアウト"
