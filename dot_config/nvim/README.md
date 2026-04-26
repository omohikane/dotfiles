# Neovim Configuration

A modular, modern, and highly functional Neovim configuration focused on speed, Japanese-specific UX, and AI integration.

## 🚀 Key Features

- **Modern & Clean UI**: `noice.nvim`, `alpha-nvim`, `barbar.nvim`.
- **AI-Powered Workflows**: `CodeCompanion`, `nvim-aibo`, and `sidekick.nvim`.
- **Superior Japanese Input**: `skkeleton` (SKK) and `kensaku`.
- **Workflow Persistence**: `Zellij` integration via `zellij-nav.nvim`.

---

## 🛠️ Requirements

- **Neovim 0.10+**
- **Nerd Fonts** (Icons)
- **Deno** (for skkeleton)
- **ripgrep (`rg`)** & **fd**

---

## ⌨️ Plugins & Keybindings

### 📂 Navigation & UI (Navigation & Explorers)
| Plugin | Key | Action |
| --- | --- | --- |
| **Neo-tree** | `<Leader>e` | Toggle File Explorer |
| | `s` / `S` | Open in Vertical / Horizontal Split (inside Neo-tree) |
| | `t` | Open in New Tab |
| **Oil.nvim** | `:Oil` | Edit filesystem as a buffer |
| **Telescope** | `<Leader>ff` | Find Files |
| | `<Leader>fg` | Live Grep |
| | `<Leader>fb` | Find Buffers |
| | `<Leader>fr` | Recent Files |
| | `<Leader>ft` | Find TODOs |

### 🧱 Buffer & Tab Management (Status & Tab Line)
| Plugin | Key | Action |
| --- | --- | --- |
| **Barbar** | `<A-,>` / `<A-.>` | Go to Previous / Next buffer |
| | `<A-c>` | Close Buffer |
| | `<A-p>` | Pin/Unpin Buffer |
| | `<C-p>` | Buffer Pick |
| | `<Leader>bo` | Close all but current |
| | `<Leader>bd` | Close current |
| **Lualine** | - | Statusline with SKK mode & LSP status |

### 💻 Coding (LSP, Completion, Snippets)
| Plugin | Key | Action |
| --- | --- | --- |
| **LSP Config** | `gd` / `gD` | Definition / Declaration |
| | `gr` / `gi` | References / Implementation |
| | `K` | Hover Documentation / Peek Fold |
| | `<Leader>rn` | Rename |
| | `<Leader>ca` | Code Action |
| | `[d` / `]d` | Previous / Next Diagnostic |
| | `<Leader>th` | Toggle Inlay Hints |
| **nvim-cmp** | `<C-n>` / `<C-p>` | Next / Previous completion item |
| | `<Tab>` / `<S-Tab>` | Navigate or Expand Snippet |
| | `<CR>` | Confirm selection |
| | `<LocalLeader>c` | Trigger completion |

### 📝 Editing & Motion (Syntax & Motion)
| Plugin | Key | Action |
| --- | --- | --- |
| **nvim-ufo** | `zR` / `zM` | Open All / Close All folds |
| **mini.surround**| `ys{motion}{char}` | Add surrounding |
| | `ds{char}` | Delete surrounding |
| | `cs{orig}{new}` | Change surrounding |
| **Comment.nvim** | `gcc` / `gbc` | Toggle Line / Block comment |
| | `gc` / `gb` | Toggle comment (Visual mode) |
| **EFT / QS** | `f` / `t` | Enhanced single-character motion |

### 🐙 Git & Version Control
| Plugin | Key | Action |
| --- | --- | --- |
| **Gitsigns** | `]c` / `[c` | Next / Prev Hunk |
| | `<Leader>gs` / `<Leader>gr` | Stage / Reset Hunk |
| | `<Leader>gb` | Toggle Line Blame |
| **Gin.vim** | `<Leader>gg` | Git Status |
| | `<Leader>gc` | Git Commit |
| | `<Leader>gl` | Git Log |
| | `<Leader>gd` | Git Diff |
| | `<Leader>gb` | Git Blame |

### 🇯🇵 Japanese Support
| Plugin | Key | Action |
| --- | --- | --- |
| **skkeleton** | `<C-j>` / `<C-q>` | Toggle SKK (Japanese input) |
| **Kensaku** | `<Leader>sk` | Japanese Fuzzy Search |

### 🤖 AI & Tools
| Plugin | Key | Action |
| --- | --- | --- |
| **CodeCompanion**| `<Leader>ac` | AI Chat |
| | `<Leader>ai` | AI Inline |
| | `<Leader>aM` | Select AI Model |
| **ToggleTerm** | `<Leader>tt` | Floating Terminal |
| | `<Leader>tg` | Lazygit (Floating) |
| **Trouble** | `<Leader>xx` | Toggle Diagnostics Panel |
| | `<Leader>xq` | Toggle Quickfix Panel |
| **Zellij Nav** | `<A-h/j/k/l>` | Navigate between windows/tabs (Zellij aware) |

---

## ⚙️ Core Keymaps (Vanilla-like)

| Key | Action |
| --- | --- |
| `<ESC>` | Clear search highlights |
| `<C-h/j/k/l>` | Move between windows |
| `<Leader>v` / `<Leader>h` | Split window Vertically / Horizontally |
| `<Leader>tn` / `<Leader>tc` | New Tab / Close Tab |
| `<Leader>fw` | Search word under cursor |
| `<Leader>sr` | Prepare global search & replace |
| `<Leader>s` | Toggle Scratchpad |

---

## 🎨 Themes
Available colorschemes: `tokyonight` (default), `kanagawa`, `nightfox`, `catppuccin`, `everforest`, `rose-pine`, `gruvbox`.
Switch using `:colorscheme <name>`.
