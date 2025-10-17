-- lua/plugins/skkeleton.lua
-- Kohaku: skkeleton + ddc 完全版
--  - グローバル辞書:  ${XDG_DATA_HOME:-~/.local/share}/skk/*
--  - ユーザー辞書  :  ${XDG_CONFIG_HOME:-~/.config}/skkeleton/SKK-JISYO.user
--  - トグル        :  <C-Space> / <C-@>（端末差異対策）
--  - ddc 連携      :  有効時は 'skkeleton' 単独、無効で元の sources に復帰
--  - lualine 表示  :  require("plugins.skkeleton").mode_label()

local M = {}

-- ===== XDG paths =====
local HOME = vim.fn.expand("~")
local DATA_HOME = (vim.env.XDG_DATA_HOME and vim.env.XDG_DATA_HOME ~= "") and vim.env.XDG_DATA_HOME
	or (HOME .. "/.local/share")
local CONFIG_HOME = (vim.env.XDG_CONFIG_HOME and vim.env.XDG_CONFIG_HOME ~= "") and vim.env.XDG_CONFIG_HOME
	or (HOME .. "/.config")

local DICT_DIR = (vim.env.SKK_DICT_DIR and vim.env.SKK_DICT_DIR ~= "") and vim.env.SKK_DICT_DIR or (DATA_HOME .. "/skk")
local USER_CONF = CONFIG_HOME .. "/skkeleton"
local USER_DICT = (vim.env.SKK_USER_DICT and vim.env.SKK_USER_DICT ~= "") and vim.env.SKK_USER_DICT
	or (USER_CONF .. "/SKK-JISYO.user")

-- ensure directories & user dictionary file
local function ensure_paths()
	if vim.fn.isdirectory(DICT_DIR) == 0 then
		vim.fn.mkdir(DICT_DIR, "p")
	end
	if vim.fn.isdirectory(USER_CONF) == 0 then
		vim.fn.mkdir(USER_CONF, "p")
	end
	if vim.fn.filereadable(USER_DICT) == 0 then
		local f = io.open(USER_DICT, "w")
		if f then
			f:write("")
			f:close()
		end
	end
end

-- collect global dictionaries (exclude compressed archives)
local function collect_global_dicts()
	local pats = {
		DICT_DIR .. "/SKK-JISYO*",
		DICT_DIR .. "/*.dic",
		DICT_DIR .. "/*.txt",
	}
	local files = {}
	for _, pat in ipairs(pats) do
		for _, p in ipairs(vim.fn.glob(pat, false, true)) do
			if not p:match("%.gz$") and not p:match("%.tar$") and not p:match("%.tar%.gz$") then
				table.insert(files, p)
			end
		end
	end
	table.sort(files)
	local dicts = {}
	for _, p in ipairs(files) do
		table.insert(dicts, { path = p, sorted = true, encoding = "utf-8" })
	end
	return dicts
end

-- ===== ddc helpers =====
local function ddc_patch_sources(list)
	if vim.fn.exists("*ddc#custom#patch_buffer") == 1 then
		vim.fn["ddc#custom#patch_buffer"]("sources", list)
	end
end

local function ddc_save_current_sources(bufnr)
	if vim.fn.exists("*ddc#custom#get_buffer") == 1 then
		local cur = vim.fn["ddc#custom#get_buffer"]().sources or {}
		vim.b[bufnr].__ddc_prev_sources = cur
	end
end

local function ddc_restore_sources(bufnr)
	local prev = vim.b[bufnr].__ddc_prev_sources
	if prev and #prev > 0 then
		ddc_patch_sources(prev)
	else
		ddc_patch_sources({ "nvim-lsp", "around", "buffer" })
	end
end

-- lualine indicator
function M.mode_label()
	if vim.fn.exists("*skkeleton#is_enabled") == 0 then
		return ""
	end
	if vim.fn["skkeleton#is_enabled"]() ~= 1 then
		return ""
	end
	local mode = vim.fn["skkeleton#mode"]()
	local map = { hira = "あ", kata = "ア", hankata = "ｱ", zenkaku = "Ａ", ["jisx0208-latin"] = "Ａ" }
	return "SKK:" .. (map[mode] or "?")
end

-- keymaps: <C-Space> / <C-@> toggle (Insert & Cmdline)
local function set_keymaps()
	local opts = { silent = true, noremap = false } -- <Plug> を通す
	vim.keymap.set("i", "<C-Space>", "<Plug>(skkeleton-toggle)", opts)
	vim.keymap.set("c", "<C-Space>", "<Plug>(skkeleton-toggle)", opts)
	vim.keymap.set("i", "<C-@>", "<Plug>(skkeleton-toggle)", opts)
	vim.keymap.set("c", "<C-@>", "<Plug>(skkeleton-toggle)", opts)
end

function M.setup()
	ensure_paths()

	-- plugin availability
	if vim.fn.exists("*skkeleton#config") == 0 then
		vim.defer_fn(function()
			vim.notify("[skkeleton] plugin not found (denops loaded later?)", vim.log.levels.WARN)
		end, 200)
		return
	end

	-- base config
	vim.fn["skkeleton#config"]({
		globalDictionaries = collect_global_dicts(),
		userDictionary = USER_DICT,
		eggLikeNewline = true,
		keepState = true,
		registerConvertResult = true,
		immediatelyOkuriConvert = false,
		showCandidatesCount = 10,
		completionRankFile = vim.fn.stdpath("state") .. "/skk-rank.json",
	})

	-- ddc look & feel for skkeleton source
	if vim.fn.exists("*ddc#custom#patch_global") == 1 then
		vim.fn["ddc#custom#patch_global"]({
			sourceOptions = {
				skkeleton = { mark = "[SKK]", matchers = {}, sorters = {}, converters = {} },
			},
		})
	end

	set_keymaps()

	-- autocmds
	local aug = vim.api.nvim_create_augroup("KohakuSkkeleton", { clear = true })

	-- enable: switch ddc to skkeleton
	vim.api.nvim_create_autocmd("User", {
		group = aug,
		pattern = "skkeleton-enable-post",
		callback = function(args)
			local bufnr = args.buf or 0
			ddc_save_current_sources(bufnr)
			ddc_patch_sources({ "skkeleton" })
			if vim.fn.exists("*ddc#enable") == 1 then
				vim.fn["ddc#enable"]()
			end
		end,
	})

	-- disable: restore previous ddc sources
	vim.api.nvim_create_autocmd("User", {
		group = aug,
		pattern = "skkeleton-disable-post",
		callback = function(args)
			local bufnr = args.buf or 0
			ddc_restore_sources(bufnr)
		end,
	})

	-- optional: tweak highlight on colorscheme change
	vim.api.nvim_create_autocmd("ColorScheme", {
		group = aug,
		callback = function()
			vim.cmd([[highlight! link SkkeletonIndicator ModeMsg]])
		end,
	})
end

return M
