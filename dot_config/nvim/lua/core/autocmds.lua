-- ==========================
-- 🌟 自動コマンド設定 (autocmds.lua)
-- ==========================

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- ユーザー定義のグループを作成
local generalGroup = augroup("GeneralSettings", {})
local filetypeGroup = augroup("FileTypeSettings", {})

-- ==========================
-- 📂 ファイルタイプごとの設定
-- ==========================

-- Markdown ファイルを開いたら自動的にラップモードを有効化
autocmd("FileType", {
    group = filetypeGroup,
    pattern = "markdown",
    command = "setlocal wrap",
})

-- JSON / YAML はインデントを 2 に設定
autocmd("FileType", {
    group = filetypeGroup,
    pattern = { "json", "yaml", "toml" },
    command = "setlocal shiftwidth=2 tabstop=2 expandtab",
})

-- Go ファイルを開いたら `goimports` を適用
autocmd("BufWritePre", {
    group = filetypeGroup,
    pattern = "*.go",
    command = "silent! lua vim.lsp.buf.format()",
})

-- ==========================
-- 🔄 ファイルの自動リロード
-- ==========================

-- 外部で変更されたファイルを自動的にリロード
autocmd("FocusGained", {
    group = generalGroup,
    command = "checktime",
})

-- ==========================
-- ✂️ バッファ & ウィンドウ管理
-- ==========================

-- `q` で閉じられるバッファを設定（ヘルプ, QuickFix, LSP 情報 など）
autocmd("FileType", {
    group = generalGroup,
    pattern = { "help", "man", "qf", "lspinfo", "startuptime" },
    command = "nnoremap <buffer> q :close<CR>",
})

-- Neovim を終了するときにターミナルバッファを閉じる
autocmd("TermClose", {
    group = generalGroup,
    pattern = "*",
    command = "if !v:event.status | exe 'bdelete! ' . expand('<abuf>') | endif",
})

-- ==========================
-- ✨ シンタックス & フォーマット
-- ==========================

-- シンタックスハイライトを強制的に再読み込み
autocmd("BufEnter", {
    group = generalGroup,
    pattern = "*",
    command = "syntax sync fromstart",
})

-- Python / JavaScript / TypeScript のファイル保存時に `format`
autocmd("BufWritePre", {
    group = generalGroup,
    pattern = { "*.py", "*.js", "*.ts" },
    command = "silent! lua vim.lsp.buf.format()",
})

-- ==========================
-- 🎨 UI 最適化
-- ==========================

-- Vim の開始時にカーソルラインをハイライト
autocmd("VimEnter", {
    group = generalGroup,
    command = "set cursorline",
})

-- ターミナルモードに入ったときに番号を非表示
autocmd("TermOpen", {
    group = generalGroup,
    command = "setlocal nonumber norelativenumber",
})

-- ==========================
-- 🚀 Neovim の起動 & 終了時の処理
-- ==========================

-- Neovim 終了時に開いているタブを保存
autocmd("VimLeave", {
    group = generalGroup,
    command = "mksession! ~/.cache/nvim/session.vim",
})

-- Neovim 起動時に前回のタブ状態を復元
autocmd("VimEnter", {
    group = generalGroup,
    command = "silent! source ~/.cache/nvim/session.vim",
})

-- ==========================
-- 🔍 半角スペース 2 個以上のハイライト
-- ==========================

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- 半角スペースが 2 個以上続く場合を強調表示
autocmd("VimEnter", {
    group = augroup("HighlightSpaces", {}),
    pattern = "*",
    callback = function()
        vim.cmd([[highlight ExtraWhitespace ctermbg=red guibg=red]])
        vim.cmd([[match ExtraWhitespace /\v  +/]])
    end,
})


