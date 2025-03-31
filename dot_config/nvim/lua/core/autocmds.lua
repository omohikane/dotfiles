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
-- 💾 セッションの保存と復元
-- ==========================

local session_path = vim.fn.stdpath("cache") .. "/session.vim"

-- Neovim 終了時にセッションを保存（安心のオートセーブ）
vim.api.nvim_create_autocmd("VimLeave", {
  group = vim.api.nvim_create_augroup("SessionSave", { clear = true }),
  command = "silent! mksession! " .. session_path,
})

-- 起動時、ファイル指定がなければセッションを復元
vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("SessionRestore", { clear = true }),
  callback = function()
    if vim.fn.argc() == 0 and vim.fn.filereadable(session_path) == 1 then
      vim.cmd("silent! source " .. session_path)
      vim.notify("🌸 セッションを復元いたしましたわ。", vim.log.levels.INFO)
    end
  end,
})

-- 保存前に不要バッファを自動で閉じる（例：空のバッファやterm）
vim.api.nvim_create_autocmd("VimLeavePre", {
  group = vim.api.nvim_create_augroup("CleanBeforeSession", { clear = true }),
  callback = function()
    -- 空バッファ（無題）を削除
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
      local name = vim.api.nvim_buf_get_name(buf)
      if name == "" or name:match("^term://") then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end
  end,
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


