-- ==========================
-- 🌟 自動コマンド設定 (autocmds.lua)
-- ==========================

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- ユーザー定義のグループを作成
local generalGroup = augroup("GeneralSettings", {})
local filetypeGroup = augroup("FileTypeSettings", {})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.expandtab = true
		vim.opt_local.smartindent = true
	end,
})

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
vim.api.nvim_create_autocmd("VimEnter", {
	group = vim.api.nvim_create_augroup("HighlightSpaces", {}),
	pattern = "*",
	callback = function()
		local colorscheme = vim.g.colors_name or ""
		local filetype = vim.bo.filetype
		local is_gui = vim.fn.has("gui_running") == 1 or vim.fn.has("termguicolors") == 1

		local guibg = "#3a1f2c" -- デフォルト：ワインレッド
		local ctermbg = 52

		-- 💡 カラースキームによって変更
		if colorscheme:match("catppuccin") then
			guibg = "#5b4b6e" -- Catppuccinに馴染む色
			ctermbg = 60
		elseif colorscheme:match("tokyonight") then
			guibg = "#313244"
			ctermbg = 236
		end

		-- 📄 ファイルタイプによって微調整（例：markdownなら軽めに）
		if filetype == "markdown" then
			guibg = "#3f3f3f"
			ctermbg = 238
		end

		-- ☀️ GUI 以外なら背景色は控えめに（下線だけ）
		if not is_gui then
			vim.cmd("highlight ExtraWhitespace gui=underline guisp=#ff8888 cterm=underline")
		else
			vim.cmd("highlight ExtraWhitespace guibg=" .. guibg .. " ctermbg=" .. ctermbg)
		end

		-- ハイライト適用
		vim.cmd([[match ExtraWhitespace /\v  +/]])
	end,
})

-- ==========================
-- ✨ 挿入モード中に直前の単語を大文字化
-- ==========================

vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("InsertUpperCase", { clear = true }),
	pattern = "*",
	callback = function()
		vim.keymap.set(
			"i",
			"<C-u>",
			"<C-g>u<Esc>mzgUiw`za",
			{ buffer = true, desc = "直前の単語を大文字に変換" }
		)
	end,
})

-- IMEを自動的にOFFにする（fcitx5）
autocmd("InsertLeave", {
	group = generalGroup,
	pattern = "*",
	callback = function()
		vim.fn.jobstart({ "fcitx5-remote", "-c" })
	end,
})

autocmd("ModeChanged", {
	group = generalGroup,
	pattern = "i:*", -- 挿入モードから他モードへ
	callback = function()
		vim.fn.jobstart({ "fcitx5-remote", "-c" })
	end,
})
