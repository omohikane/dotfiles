# dotfiles

Personal dotfiles optimized for a high-performance Linux workflow, primarily targeting **Wayland** with a fallback/parallel support for X11.

## 🛠 Managed Tools & Key Features

### Desktop Environment (Wayland focus)
*   **Window Manager**: `Sway` (Wayland) / `i3` (X11). Unified configuration style for tiling window management.
*   **Display Management**: `Kanshi` for dynamic output configuration (e.g., auto-switching between laptop and dock setups).
*   **Status Bar**: `Waybar`. Features custom CSS styling and modules for resource monitoring and system controls.
*   **App Launcher**: `Fuzzel`. A lightweight Wayland-native runner.

### Terminal & Shell
*   **Terminal**: `Alacritty`. High-performance, GPU-accelerated terminal.
*   **Shell**: `Fish`. Custom functions and themes located in `private_fish/`. Includes optimized completions and git integration.
*   **Workspace**: `Zellij`. A modern terminal multiplexer used for managing persistent sessions with a user-friendly UI.

### Neovim (Full-featured IDE)
Located in `dot_config/nvim/`, this is a deep Lua-based configuration:
*   **Package Management**: `dpp.vim` + `denops.vim`. Utilizes a fast, asynchronous plugin loading system.
*   **Modern Completion**: `ddc.vim` for a flexible, highly customizable completion engine.
*   **AI Assistant**: `CodeCompanion.lua` integrated with local LLMs (Ollama) and cloud providers.
*   **LSP & Syntax**: Robust support for Go, Elixir, TypeScript, and Python via `nvim-lspconfig` and `Tree-sitter`.
*   **Code Quality**: Automated formatting with `conform.nvim` and asynchronous linting with `nvim-lint`.

## 📂 Directory Structure

Managed using a `chezmoi`-compatible structure:

| Source Path | Target (~/.config/) | Description |
|:--- |:--- |:--- |
| `dot_config/nvim/` | `nvim/` | Neovim Lua configuration & plugin specs |
| `dot_config/sway/` | `sway/` | Sway window manager settings |
| `dot_config/waybar/` | `waybar/` | Status bar layout & styling |
| `private_fish/` | `fish/` | Fish shell config, functions, & history |
| `dot_config/alacritty/`| `alacritty/` | Terminal colors and font settings |

## 🚀 Getting Started

These files are intended to be managed by [chezmoi](https://www.chezmoi.io/).

1.  Install `chezmoi`.
2.  Initialize: `chezmoi init https://github.com/yourusername/dotfiles.git`
3.  Apply: `chezmoi apply`

## 📝 Notes

This environment is optimized for Wayland. For X11 users, the `i3` configuration provides a consistent experience but lacks some of the modern status bar and notification features found in the Wayland stack.
