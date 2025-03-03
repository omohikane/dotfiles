-- ==========================
-- 🌟 キーマッピング設定 (keymaps.lua)
-- ==========================

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true } -- 基本オプション

-- ==========================
-- 📄 Markdown プレビュー
-- ==========================

-- Markdown のプレビューを開始
keymap("n", "<Leader>mdp", ":MarkdownPreview<CR>", opts)

-- Markdown のプレビューを停止
keymap("n", "<Leader>mps", ":MarkdownPreviewStop<CR>", opts)

-- Markdown のプレビューをトグル
keymap("n", "<Leader>mpo", ":MarkdownPreviewToggle<CR>", opts)

-- ==========================
-- 🚀 基本操作のキーバインド
-- ==========================

-- ESC で検索ハイライト解除
keymap("n", "<ESC>", ":nohlsearch<CR>", opts)

-- ==========================
-- 🖥️ ウィンドウ & タブ操作
-- ==========================

-- ウィンドウ移動
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)

-- ウィンドウを縦に分割
keymap("n", "<Leader>v", ":vsplit<CR>", opts)

-- ウィンドウを横に分割
keymap("n", "<Leader>h", ":split<CR>", opts)

-- タブ操作
keymap("n", "<Leader>tn", ":tabnew<CR>", opts) -- 新しいタブを開く
keymap("n", "<Leader>tc", ":tabclose<CR>", opts) -- タブを閉じる
keymap("n", "<Leader>to", ":tabonly<CR>", opts) -- 他のタブを閉じる
keymap("n", "<Leader>tp", ":tabprevious<CR>", opts) -- 前のタブへ
keymap("n", "<Leader>tn", ":tabnext<CR>", opts) -- 次のタブへ

-- ==========================
-- 🔍 検索・置換
-- ==========================

-- カーソル位置の単語を検索
keymap("n", "<Leader>fw", "*N", opts)

-- ファイル内で文字列を置換
keymap("n", "<Leader>sr", ":%s//g<Left><Left>", opts)

-- ==========================
-- 📂 ファイルナビゲーション
-- ==========================

-- ファイルエクスプローラーを開く（nvim-tree.lua）
keymap("n", "<Leader>e", ":NvimTreeToggle<CR>", opts)

-- ==========================
-- 🚀 ターミナルモードの改善
-- ==========================

-- ESC でターミナルモードを抜ける
keymap("t", "<ESC>", "<C-\\><C-n>", opts)

-- ターミナルを開く
keymap("n", "<Leader>tt", ":split | terminal<CR>", opts)

-- ==========================
-- ⌨️ 日本語入力時の IME 自動 OFF
-- ==========================

local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- カーソル移動で IME を自動 OFF
keymap("i", "<C-l>", "<ESC><Right>", opts)
keymap("i", "<C-h>", "<ESC><Left>", opts)

-- `jj` や `kk` でも IME を自動 OFF
keymap("i", "jj", "<ESC>", opts)
keymap("i", "kk", "<ESC>", opts)

