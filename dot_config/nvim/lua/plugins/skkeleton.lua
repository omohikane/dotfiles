-- lua/plugins/skkeleton.lua

local M = {}

local DICT_DIR = vim.env.SKK_DICT_DIR
	or (
		vim.fn.expand("$XDG_DATA_HOME") ~= "" and (vim.fn.expand("$XDG_DATA_HOME") .. "/skk")
		or (vim.fn.expand("~/.local/share/skk"))
	)
local USER_DICT = vim.env.SKK_USER_DICT or (DICT_DIR .. "/SKK-JISYO.user")

local function ensure_paths()
	if vim.fn.isdirectory(DICT_DIR) == 0 then
		vim.fn.mkdir(DICT_DIR, "p")
	end
	if vim.fn.filereadable(USER_DICT) == 0 then
		local f = io.open(USER_DICT, "w")
		if f then
			f:write("")
			f:close()
		end
	end
end

local function collect_global_dicts()
	local patterns = {
		DICT_DIR .. "/SKK-JISYO*",
		DICT_DIR .. "/*.dic",
		DICT_DIR .. "/*.txt",
	}
	local files = {}
	for _, pat in ipairs(patterns) do
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

local function ddc_patch_sources(list)
	if vim.fn.exists("*ddc#custom#patch_buffer") == 0 then
		return
	end
	vim.fn["ddc#custom#patch_buffer"]("sources", list)
end

local function ddc_save_current_sources(bufnr)
	if vim.fn.exists("*ddc#custom#get_buffer") == 0 then
		return
	end
	local cur = vim.fn["ddc#custom#get_buffer"]().sources or {}
	vim.b[bufnr].__ddc_prev_sources = cur
end

local function ddc_restore_sources(bufnr)
	local prev = vim.b[bufnr].__ddc_prev_sources
	if prev and #prev > 0 then
		ddc_patch_sources(prev)
	else
		ddc_patch_sources({ "nvim-lsp", "around", "buffer" })
	end
end

function M.mode_label()
	if vim.fn.exists("*skkeleton#is_enabled") == 0 then
		return ""
	end
	if vim.fn["skkeleton#is_enabled"]() ~= 1 then
		return ""
	end
	local mode = vim.fn["skkeleton#mode"]() -- 'hira'|'kata'|'hankata'|'zenkaku'|'jisx0208-latin'等
	local map = {
		hira = "あ",
		kata = "ア",
		hankata = "ｱ",
		zenkaku = "Ａ",
		["jisx0208-latin"] = "Ａ",
	}
	return string.format("SKK:%s", map[mode] or "?")
end

local function set_keymaps()
	vim.keymap.set("i", "<C-j>", "<Plug>(skkeleton-toggle)", { silent = true })
	vim.keymap.set("c", "<C-j>", "<Plug>(skkeleton-toggle)", { silent = true })
end

function M.setup()
	ensure_paths()

	if vim.fn.exists("*skkeleton#config") == 0 then
		vim.defer_fn(function()
			vim.notify("[skkeleton] plugin not found (denops loaded?)", vim.log.levels.WARN)
		end, 300)
		return
	end

	local dicts = collect_global_dicts()
	vim.fn["skkeleton#config"]({
		globalDictionaries = dicts,
		userDictionary = USER_DICT,
		eggLikeNewline = true,
		keepState = true,
		registerConvertResult = true,
		immediatelyOkuriConvert = false,
		showCandidatesCount = 10,
		completionRankFile = vim.fn.stdpath("state") .. "/skk-rank.json",
	})

	if vim.fn.exists("*ddc#custom#patch_global") == 1 then
		vim.fn["ddc#custom#patch_global"]({
			sourceOptions = {
				skkeleton = {
					mark = "[SKK]",
					matchers = {},
					sorters = {},
					converters = {},
				},
			},
		})
	end

	set_keymaps()

	local aug = vim.api.nvim_create_augroup("KohakuSkkeleton", { clear = true })

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

	vim.api.nvim_create_autocmd("User", {
		group = aug,
		pattern = "skkeleton-disable-post",
		callback = function(args)
			local bufnr = args.buf or 0
			ddc_restore_sources(bufnr)
		end,
	})

	vim.api.nvim_create_autocmd("ColorScheme", {
		group = aug,
		callback = function()
			vim.cmd([[highlight! link SkkeletonIndicator ModeMsg]])
		end,
	})
end

return M
