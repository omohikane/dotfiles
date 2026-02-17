# dotfiles

My personal dotfiles for a customized Linux environment.

## Overview

This repository contains configuration files for various applications I use, primarily focused on a tiling window manager setup (i3/Sway) with Alacritty, Neovim, Fish shell, etc.

The configurations are managed under the `dot_config` directory, intended to be symlinked to `~/.config/`.

## Included Configurations

*   **Window Managers**:
    *   `i3/`
    *   `sway/`
    *   `kanshi/` (for display profile management with Sway)
*   **Terminal Emulator**: `alacritty/`
*   **Text Editor**: `nvim/` (Lua-based configuration)
*   **Shell**: `private_fish/` (Fish shell configurations, functions, themes)
*   **Status Bar**: `waybar/`
*   **Application Launcher**: `fuzzel/`
*   **Terminal Multiplexer**: `zellij/`
*   **Environment Variables**: `environment.d/`

## Directory Structure & Managed Tools

This repository uses a structure compatible with managers like `chezmoi`, where `dot_config` maps to `~/.config`.

### Core Environment
*   **Window Manager**: `Sway` (Wayland) / `i3` (X11)
*   **Bar**: `Waybar` - Highly customized status bar.
*   **Terminal**: `Alacritty` - GPU-accelerated terminal emulator.
*   **Shell**: `Fish` - Located in `private_fish/` with custom functions and themes.
*   **Multiplexer**: `Zellij` - Modern terminal workspace.
*   **Launcher**: `Fuzzel` - Wayland-native application launcher.

### Neovim (`dot_config/nvim/`)
A comprehensive Lua-based IDE-like setup featuring:
*   **Package Manager**: `dpp.vim` for efficient plugin management.
*   **AI Integration**: `CodeCompanion.lua` configured with Ollama/CodeLlama/Llama3.
*   **LSP**: Configured via `nvim-lspconfig` for Go, TypeScript, Elixir, Python, Lua, and more.
*   **Formatting/Linting**: `conform.nvim` and `nvim-lint`.
*   **UI**: `Telescope`, `Lualine`, `Barbar`, and `Fidget`.
*   **Syntax**: `Tree-sitter` for advanced highlighting and text objects.

## Notes

This configuration is optimized for a fast, modern Linux workflow using Wayland.
