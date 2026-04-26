# Neovim Plugin Mastery Practice Plan 🚀

This plan is designed to help you internalize your Neovim configuration through focused practice sessions. Each session covers a specific area of your workflow.

---

## 🗓️ Session 1: Navigation & Workspace Management
**Goal**: Move through files and windows without thinking.

1.  **File Exploration**:
    - Open `Neo-tree` with `<Leader>e`.
    - Navigate to a file and open it in a vertical split using `s`.
    - Try opening another file in a horizontal split with `S`.
    - Close Neo-tree with `<Leader>e`.
2.  **Fuzzy Finding**:
    - Search for a file by name with `<Leader>ff`.
    - Search for a word across the project with `<Leader>fg`.
    - Switch between open buffers with `<Leader>fb`.
3.  **Buffer Management**:
    - Open 5 different files.
    - Move between them using `<A-,>` and `<A-.>`.
    - "Pick" a buffer visually with `<C-p>`.
    - Pin an important file with `<A-p>`.
    - Close all other buffers except the pinned one with `<Leader>bo`.

---

## 🗓️ Session 2: The Coding Engine (LSP & Folds)
**Goal**: Leverage IDE-like features and manage large files.

1.  **LSP Navigation**:
    - Jump to a function definition with `gd`.
    - See all references of a variable with `gr`.
    - Rename a variable across the file with `<Leader>rn`.
    - View diagnostic errors with `[d` and `]d`.
2.  **Code Folding (ufo)**:
    - Close all folds in a large file with `zM`.
    - Open all folds with `zR`.
    - Hover over a folded line and press `K` to peek inside without opening it.
3.  **Formatting & Linting**:
    - Intentionally mess up the indentation in a `.lua` or `.go` file.
    - Save the file (`:w`) and watch `conform.nvim` fix it automatically.

---

## 🗓️ Session 3: Speed Editing & Motions
**Goal**: Edit text with minimal keystrokes.

1.  **Surround (mini.surround)**:
    - Add double quotes to a word: `ysiw"`.
    - Change double quotes to single quotes: `cs"'`.
    - Delete quotes: `ds'`.
    - Wrap a visual selection in tags: Select text -> `S` -> type `<div>`.
2.  **Commenting**:
    - Comment a line with `gcc`.
    - Comment a block of code by selecting it and pressing `gc`.
3.  **Smart Motions**:
    - Use `f` and `t` to jump across a line. Notice how `quick-scope` highlights unique characters to target.
    - Use `EFT` enhancements for more precise jumping.

---

## 🗓️ Session 4: Git & Japanese Integration
**Goal**: Handle version control and Japanese text seamlessly.

1.  **Git Hunks**:
    - Modify a file and look for the colored signs in the signcolumn.
    - Jump between changes with `]c` and `[c`.
    - Preview the change or stage a single hunk with `<Leader>gs`.
    - Toggle the "blame" line with `<Leader>gb`.
2.  **Japanese Workflow**:
    - Toggle Japanese input with `<C-j>` or `<C-q>`.
    - Type some Japanese and convert using `skkeleton`.
    - Search for a Japanese word in your code using `<Leader>sk` (Kensaku).

---

## 🗓️ Session 5: Advanced AI & Terminal
**Goal**: Integrate AI assistance and manage external tools.

1.  **AI Chat (CodeCompanion)**:
    - Open the AI chat with `<Leader>ac`.
    - Ask a question about your current buffer.
    - Select a model with `<Leader>aM` if needed.
2.  **AI Inline Edit**:
    - Select a block of code and press `<Leader>ai`.
    - Ask the AI to "Refactor this to be more efficient".
3.  **Terminal Management**:
    - Open a floating terminal with `<Leader>tt`.
    - Open `lazygit` directly with `<Leader>tg`.
    - Navigate between Neovim windows and Zellij panes using `<A-h/j/k/l>`.

---

## ✅ How to use this plan
- Spend **15 minutes a day** on one session.
- Repeat a session until the keybindings feel like muscle memory.
- Check off the items as you master them!
