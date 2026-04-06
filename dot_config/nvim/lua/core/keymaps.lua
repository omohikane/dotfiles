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

-- TODO リストを表示 (todo-comments.nvim)
keymap("n", "<Leader>ft", "<cmd>TodoTelescope<CR>", { desc = "プロジェクト内の TODO を検索" })

-- ファイル内で文字列を置換
keymap("n", "<Leader>sr", ":%s//g<Left><Left>", { silent = false })

-- ==========================
-- 📂 ファイルナビゲーション
-- ==========================

-- ファイルエクスプローラーを開く（neotree.lua）
keymap("n", "<Leader>e", "<cmd>Neotree reveal toggle<CR>", opts)

-- ==========================
-- 🚀 ターミナルモードの改善
-- ==========================

-- ESC でターミナルモードを抜ける
keymap("t", "<ESC>", [[<C-\><C-n>]], opts)

-- ターミナルを開く
keymap("n", "<Leader>tt", "<cmd>split | terminal<CR>", opts)

-- ==========================
-- 📝 自作軽量スクラッチパッド
-- ==========================
keymap("n", "<Leader>s", function() require("core.scratch").toggle_scratch() end, { desc = "スクラッチパッドを開く/閉じる", silent = true })

-- ==========================
-- ⌨️ 日本語入力時の IME 自動 OFF
-- ==========================

-- カーソル移動で IME を自動 OFF
keymap("i", "<C-l>", "<ESC><Right>", opts)
keymap("i", "<C-h>", "<ESC><Left>", opts)

-- `jj` や `kk` でも IME を自動 OFF
-- keymap("i", "jj", "<ESC>", opts)
-- keymap("i", "kk", "<ESC>", opts)

-- ==========================
-- 🛠️ バッファ強制操作
-- ==========================

-- 🛠️ バッファ操作 (Barbar / 整理)
keymap("n", "<Leader>bb", "<cmd>Telescope buffers<CR>", { desc = "開いているバッファを一覧表示", silent = true })
keymap("n", "<Leader>bd", "<cmd>BufferClose<CR>", { desc = "現在のバッファを閉じる", silent = true })

-- 保存せずにバッファを強制終了
keymap("n", "<A-C>", "<cmd>bd!<CR>", { desc = "保存せずバッファを強制終了", silent = true })

-- 現在のバッファを保存不要モードに変更
keymap("n", "<Leader>sc", function() require("core.scratch").set_scratch() end, { desc = "このバッファを保存不要モードにする", silent = true })

