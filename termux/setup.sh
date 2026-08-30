#!/usr/bin/env bash
set -euo pipefail

# termux/setup.sh - Termux one-shot setup for razr 50 + Clicks
# Usage (on Termux):
#   pkg update -y && pkg install -y git openssh
#   git clone https://github.com/omohikane/dotfiles.git ~/dotfiles
#   cd ~/dotfiles/termux && bash setup.sh
# Or via chezmoi: this file lives under chezmoi source at termux/setup.sh

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"
# When run via ~/dotfiles/termux/setup.sh, DOTFILES_DIR is ~/dotfiles
# When run via chezmoi source, fallback to expected Termux dotfiles path
if [[ ! -d "$DOTFILES_DIR/termux" ]]; then
  DOTFILES_DIR="$HOME/dotfiles"
fi

echo "==> Dotfiles dir: $DOTFILES_DIR"
echo "==> Updating packages (Termux)..."
if command -v pkg >/dev/null 2>&1; then
  pkg update -y && pkg upgrade -y
else
  echo "[WARN] pkg not found - are you on Termux? Skipping pkg update."
fi

echo "==> Installing essentials..."
if command -v pkg >/dev/null 2>&1; then
  pkg install -y git openssh mosh fish zellij termux-api termux-tools bat fzf ripgrep openssh 2>/dev/null || pkg install -y git openssh mosh fish zellij termux-api
  # starship/zoxideは任意
  pkg install -y starship zoxide 2>/dev/null || true
fi

echo "==> Setting up Termux properties..."
mkdir -p ~/.termux
if [[ -f "$DOTFILES_DIR/termux/termux.properties" ]]; then
  ln -sf "$DOTFILES_DIR/termux/termux.properties" ~/.termux/termux.properties
  echo "  linked termux.properties"
fi
if [[ -f "$DOTFILES_DIR/termux/termux-styling.properties" ]] && [[ -f "$DOTFILES_DIR/termux/colors.properties" ]]; then
  ln -sf "$DOTFILES_DIR/termux/colors.properties" ~/.termux/colors.properties
fi

if command -v termux-reload-settings >/dev/null 2>&1; then
  termux-reload-settings || true
  echo "  termux-reload-settings done"
fi

echo "==> Setting up fish config (Termux)..."
mkdir -p ~/.config/fish/conf.d
if [[ -f "$DOTFILES_DIR/termux/fish-termux.fish" ]]; then
  ln -sf "$DOTFILES_DIR/termux/fish-termux.fish" ~/.config/fish/conf.d/termux-phone.fish
  echo "  linked fish-termux.fish -> ~/.config/fish/conf.d/termux-phone.fish"
fi

echo "==> Setting up SSH (Termux -> Home)..."
mkdir -p ~/.ssh && chmod 700 ~/.ssh
# Termux側のSSH鍵が無ければ生成を促す。既存鍵は上書きしない
if [[ ! -f ~/.ssh/id_ed25519 ]]; then
  echo "  [INFO] No ~/.ssh/id_ed25519 found. Generating one..."
  ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N "" -C "termux-razr50-$(date +%Y%m%d)"
  echo "  Generated. Add this public key to your home server's authorized_keys:"
  echo "  ---"
  cat ~/.ssh/id_ed25519.pub
  echo "  ---"
  echo "  On home server (Endeavour): cat >> ~/.ssh/authorized_keys"
else
  echo "  Existing key found: ~/.ssh/id_ed25519 (skip)"
fi

# Homeへのssh config雛形
if [[ ! -f ~/.ssh/config ]] && [[ -f "$DOTFILES_DIR/termux/ssh-config.example" ]]; then
  cp "$DOTFILES_DIR/termux/ssh-config.example" ~/.ssh/config
  chmod 600 ~/.ssh/config
  echo "  installed ssh config template -> ~/.ssh/config (edit HostName/User as needed)"
elif [[ -f "$DOTFILES_DIR/termux/ssh-config.example" ]]; then
  echo "  [INFO] ~/.ssh/config already exists. Compare with template:"
  echo "        $DOTFILES_DIR/termux/ssh-config.example"
fi

echo ""
echo "All set! Next steps:"
echo "  1. Ensure NetBird on Termux/Android is connected (netbird.cloud)"
echo "  2. Copy ~/.ssh/id_ed25519.pub to home server: ssh-copy-id or manual append"
echo "  3. Test: ssh r1ppl3@endeavour-desktop-ryzen.netbird.cloud"
echo "  4. Then: ssh -t r1ppl3@endeavour-desktop-ryzen.netbird.cloud 'zellij attach -c main'"
echo "     or phone layout: ssh -t r1ppl3@endeavour-desktop-ryzen.netbird.cloud 'zellij --layout phone attach -c phone'"
echo "  5. Optional: set default fish shell: chsh -s fish"
