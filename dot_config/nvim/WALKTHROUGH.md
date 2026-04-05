# Walkthrough - Neovim Modernization & AI/Zellij Integration

A complete, high-performance Neovim environment (v0.12 ready) with seamless Zellij integration and multiple AI workflows.

## 🚀 Key Features Implemented

### 1. Modern Plugin Architecture
- **Lazy.nvim Migration**: All plugins are now organized in a modular `lua/plugins/` structure.
- **Neovim v0.11+ Support**: Updated to the latest LSP APIs (`vim.lsp.config`) and Treesitter configurations.

### 2. Japanese Input & Display Excellence
- **skkeleton Optimized**: Full integration with `nvim-cmp` for smooth Japanese conversion.
- **Fixed Width Errors**: Resolved "Invalid argument" (E474) and "Wrong character width" (E1512) errors caused by `ambiwidth=double` by using robust ASCII fillchars and a custom UI.

### 3. Zellij Mastery (Distraction-Free AI)
- **Seamless Navigation**: Move between Neovim and Zellij panes with `Alt-h/j/k/l`.
- **Auto-Sync**: Neovim now automatically reloads files (`autoread`) when external AI tools (like `aider`) modify them in another Zellij pane.

### 4. Dual AI Workflows
- **Quick Assistant**: Use **`<Leader>ai`** to open a quick AI assistant (`nvim-aibo`) inside Neovim for short questions.
- **Full-Pane AI**: Dedicate a Zellij pane to `aider` or `claude-code` for intensive project-wide tasks.

### 5. Custom Lightweight Scratchpad
- **Fast & Robust**: Replaced heavy plugins with a custom Lua implementation (`<Leader>s`).
- **Org-mode Enabled**: A floating, discardable Org-mode buffer for quick thoughts, headers, and notes.

---

## ⌨️ Essential Keybindings

| Key | Action |
| --- | --- |
| `<Leader>s` | **Toggle Scratchpad** (Floating Org-mode) |
| `q` | Close many floating windows (Scratch, AI, etc.) |
| `<Leader>ai` | **Open AI Assistant** (nvim-aibo) |
| `Alt + h/j/k/l` | **Zellij Navigation** (Navigate panes/Vim) |
| `<Leader>e` | Toggle File Explorer (Neo-tree) |
| `<Leader>ff` | Search Files (Telescope) |

---

## 🏗️ Project Structure
- `init.lua`: Core bootstrap and loader.
- `lua/core/`: Options, keymaps, and the new **[scratch.lua](file:///home/r1ppl3/.config/nvim/lua/core/scratch.lua)**.
- `lua/plugins/`: Modularized plugin definitions categorized by function.

> [!TIP]
> **Pro Tip**: When using AI in a separate Zellij pane, Neovim will automatically pick up the changes. You can use `<Leader>s` to quickly draft your thoughts before pasting them into your AI instructions!

Enjoy your new focused, high-performance development environment!
