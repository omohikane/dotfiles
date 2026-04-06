# Neovim Configuration

A modular, modern, and highly functional Neovim configuration focused on speed, Japanese-specific UX, and AI integration.

## 🚀 Key Features

- **Modern & Clean UI**: 
    - `noice.nvim` for refined command line/notifications. 
    - `alpha-nvim` for a custom ASCII dashboard.
    - `barbar.nvim` for buffer management.
- **AI-Powered (Antigravity-like) Workflows**: 
    - **Gemini CLI** integration in a 40% vertical split.
    - Context-aware code sending and interactive sessions via `nvim-aibo`.
    - **Aider** support for multi-file editing.
- **Superior Japanese Input (SKK)**: 
    - **skkeleton** for smooth Japanese input.
    - **Safe-Input Prompt Window**: Prevents accidental "Submit-on-Enter" during conversion.
    - **Status Indication**: Real-time mode display in `lualine` (statusline) and a floating indicator near the cursor.
- **Workflow Persistence**: **Zellij** integration for managing persistent terminal sessions and logs alongside Neovim.

---

## 🛠️ Requirements

- **Neovim 0.10+** (Core)
- **Nerd Fonts** (Icons)
- **Deno** (for denops/skkeleton)
- **ripgrep (`rg`)** / **fd** (Telescope)
- **Gemini CLI** / **Aider** (optional for AI)
- **Zellij** (Terminal multiplication)

---

## ⌨️ Keybindings (By Function)

### 📂 Navigation & UI
| Key | Action |
| --- | --- |
| `<Leader>e` | Toggle File Explorer (Neo-tree) |
| `<C-h/j/k/l>` | Move between windows |
| `<Leader>v` / `<Leader>h` | Split window Vertically / Horizontally |
| `<Leader>tn` / `<Leader>tc` | Tab New / Tab Close |

### 🔍 Search & Find
| Key | Action |
| --- | --- |
| `<Leader>ff` | Find Files (Telescope) |
| `<Leader>fg` | Live Grep (search content) |
| `<Leader>fb` (or `bb`) | Search Open Buffers |
| `<Leader>ft` | Find TODOs / FIXMEs |
| `<Leader>sk` | Japanese fuzzy search (Kensaku) |

### 🤖 AI Toolkit (Space + a)
| Key | Action |
| --- | --- |
| `<Leader>ai` | **Open Gemini Chat** (40% Vertical Split) |
| `<Leader>aa` | **Launch Aider** (Integrated terminal) |
| `<Leader>as` | **Submit Context**: Send buffer/selection to AI |
| `<Leader>ar` | **Resume latest session** |

### 🧱 Buffer & Tab Management
| Key | Action |
| --- | --- |
| `<A-,>` / `<A-.>` | Go to Previous / Next buffer |
| `<A-c>` / `<A-C>` | Close Buffer / **Force Close** buffer |
| `<A-p>` | Pin/Unpin current buffer |
| `<Leader>bo` | **Clean up**: Close all EXCEPT current |
| `<Leader>bp` | **Clean up**: Close all EXCEPT pinned |
| `<Leader>bsd` / `bsl` | Sort by Directory / Language |

---

## 💡 Pro Tips

### Japanese Input Safety in AI
When using Gemini Chat, **type in the small floating prompt window** at the bottom. Since this is a normal Neovim buffer, you can use **skkeleton (SKK)** to convert Japanese safely without worrying about `Enter` sending the message by mistake. When ready, hit `Ctrl+Enter` or type `:w` to submit.

### Persistent Terminal (Zellij)
For long-running tasks or viewing broad system logs, use **Zellij** to manage multiple panes outside of Neovim. Neovim's `autoread` and session management will ensure your code and context stay in sync.

---

## 🎨 Dashboard (ASCII Art)
Add your own `.txt` files to `~/.config/nvim/ascii/`. A random art piece is selected from this directory every time you start Neovim for a fresh dashboard experience.
