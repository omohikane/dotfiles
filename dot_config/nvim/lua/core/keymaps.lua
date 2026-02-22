-- ==========================
-- 🌟 キーマッピング設定 (keymaps.lua)
-- ==========================

local keymap = vim.keymap.set
local opts = { silent = true } -- 基本オプション

-- ==========================
-- 📄 Markdown プレビュー
-- ==========================

-- Markdown のプレビューを開始
keymap("n", "<Leader>mdp", "<cmd>MarkdownPreview<CR>", opts)

-- Markdown のプレビューを停止
keymap("n", "<Leader>mps", "<cmd>MarkdownPreviewStop<CR>", opts)

-- Markdown のプレビューをトグル
keymap("n", "<Leader>mpo", "<cmd>MarkdownPreviewToggle<CR>", opts)

-- ==========================
-- 🚀 基本操作のキーバインド
-- ==========================

-- ESC で検索ハイライト解除
keymap("n", "<ESC>", "<cmd>nohlsearch<CR>", opts)

-- ==========================
-- 🖥️ ウィンドウ & タブ操作
-- ==========================

-- ウィンドウ移動
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)

-- ウィンドウを縦に分割
keymap("n", "<Leader>v", "<cmd>vsplit<CR>", opts)

-- ウィンドウを横に分割
keymap("n", "<Leader>h", "<cmd>split<CR>", opts)

-- タブ操作
keymap("n", "<Leader>tn", "<cmd>tabnew<CR>", opts) -- 新しいタブを開く
keymap("n", "<Leader>tc", "<cmd>tabclose<CR>", opts) -- タブを閉じる
keymap("n", "<Leader>to", "<cmd>tabonly<CR>", opts) -- 他のタブを閉じる
keymap("n", "<Leader>tp", "<cmd>tabprevious<CR>", opts) -- 前のタブへ

-- ==========================
-- 🔍 検索・置換
-- ==========================

-- カーソル位置の単語を検索
keymap("n", "<Leader>fw", "*N", opts)

-- ファイル内で文字列を置換
keymap("n", "<Leader>sr", ":%s//g<Left><Left>", { silent = false })

-- ==========================
-- 📂 ファイルナビゲーション
-- ==========================

-- ファイルエクスプローラーを開く（neotree.lua）
keymap("n", "<Leader>e", "<cmd>Neotree reveal toggle<CR>", opts)

-- ==========================
-- 🤖 AI Assistant (nvim-aibo)
-- ==========================

-- Claude を開く
keymap("n", "<Leader>ai", "<cmd>Claude<CR>", { desc = "Open Claude AI" })

-- バッファの内容を Claude に送る
keymap("n", "<Leader>as", "<cmd>AiboSend -submit<CR>", { desc = "Send buffer to AI" })
keymap("v", "<Leader>as", ":AiboSend -submit<CR>", { desc = "Send selection to AI" })

-- ==========================
-- 🚀 ターミナルモードの改善
-- ==========================

-- ESC でターミナルモードを抜ける
keymap("t", "<ESC>", [[<C-\><C-n>]], opts)

-- ターミナルを開く
keymap("n", "<Leader>tt", "<cmd>split | terminal<CR>", opts)

-- ==========================
-- ⌨️ 日本語入力時の IME 自動 OFF
-- ==========================

-- カーソル移動で IME を自動 OFF
keymap("i", "<C-l>", "<ESC><Right>", opts)
keymap("i", "<C-h>", "<ESC><Left>", opts)

-- `jj` や `kk` でも IME を自動 OFF
-- keymap("i", "jj", "<ESC>", opts)
-- keymap("i", "kk", "<ESC>", opts)

