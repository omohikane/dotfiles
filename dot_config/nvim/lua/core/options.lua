local opt = vim.opt -- 設定のショートカット

-- ==========================
-- 🌟 基本エディタ設定
-- ==========================

-- タブの幅を 2 に設定
opt.tabstop = 2

-- インデントの幅を 2 に設定
opt.shiftwidth = 2

-- タブをスペースに変換
opt.expandtab = true

-- 改行時に前の行のインデントを継承
opt.autoindent = true

-- スマートインデントを有効化
opt.smartindent = true

-- ==========================
-- 🔎 検索設定
-- ==========================

-- インクリメンタル検索を有効化
opt.incsearch = true

-- 大文字小文字を無視
opt.ignorecase = true

-- 大文字が含まれている場合は区別
opt.smartcase = true

-- ==========================
-- 📂 ファイル管理
-- ==========================

-- バックアップファイルを作成しない
opt.backup = false

-- 上書き時のバックアップを無効化
opt.writebackup = false

-- スワップファイルを作成しない
opt.swapfile = false

-- アンドゥ履歴を保存
opt.undofile = true

-- アンドゥ履歴の保存場所
opt.undodir = vim.fn.stdpath("cache") .. "/undo"

-- ==========================
-- 🎨 表示関連
-- ==========================

-- 行番号を表示
opt.number = true

-- 相対行番号を表示
opt.relativenumber = true

-- カーソル行をハイライト
opt.cursorline = true

-- インデントベースの折りたたみを有効化
opt.foldmethod = "indent"

-- デフォルトで全て展開
opt.foldlevel = 99

-- 24bit カラー対応
opt.termguicolors = true

-- シンボルカラムを常に表示
opt.signcolumn = "yes"

-- テキストの折り返しを無効化
opt.wrap = false

-- ==========================
-- ✂️ クリップボード設定
-- ==========================

-- クリップボードを OS と共有 (Windows/Wsl/Linux)
opt.clipboard = "unnamedplus"

-- ==========================
-- ⚡ パフォーマンス調整
-- ==========================

-- イベント発火の遅延時間 (デフォルト: 4000ms)
opt.updatetime = 300

-- キーマップ待機時間 (デフォルト: 1000ms)
opt.timeoutlen = 500

-- スクロール中の描画を遅延させて高速化
opt.lazyredraw = true

-- 長いシンタックスハイライトの描画時間を延長
opt.redrawtime = 10000

-- ==========================
-- 🖱️ マウス & その他の設定
-- ==========================

-- 全モードでマウスを有効化
opt.mouse = "a"

-- 新しいウィンドウは下に開く
opt.splitbelow = true

-- 新しいウィンドウは右に開く
opt.splitright = true

-- 補完の動作を設定
opt.completeopt = { "menuone", "noselect" }

-- メッセージを最小限にする
opt.shortmess:append("c")

-- 行の移動を矢印キーで可能にする
opt.whichwrap:append("<,>,[,]")

-- ==========================
-- 🌏 日本語入力 & エンコーディング
-- ==========================

-- ファイルのエンコーディングを UTF-8 に統一
vim.opt.encoding = "utf-8"
vim.opt.fileencodings = { "utf-8", "sjis", "euc-jp" }

-- 日本語の文字幅を適切に調整
vim.opt.ambiwidth = "double"


