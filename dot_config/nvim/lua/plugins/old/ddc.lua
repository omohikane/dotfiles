-- plugins/ddc.lua

-- local function ddc_has_native_ui()
-- 	local base = vim.fn.stdpath("cache") .. "/dpp"
-- 	local repo = base .. "/repos/github.com/Shougo/ddc-ui-native/denops/@ddc-uis/native.ts"
-- 	local snap = base .. "/nvim/.dpp/denops/@ddc-uis/native.ts"
-- 	return vim.fn.filereadable(repo) == 1 or vim.fn.filereadable(snap) == 1
-- end

-- rtp に ddc-source-nvim-lsp が見えているか
local function has_lsp_source()
	return vim.fn.globpath(vim.o.rtp, "denops/@ddc-sources/nvim-lsp.ts") ~= ""
end

local function setup_ddc_global_options()
	-- local ui_name = ddc_has_native_ui() and "native" or "pum"
	vim.fn["ddc#custom#patch_global"]({
		ui = "pum",
		autoCompleteEvents = { "InsertEnter", "TextChangedI", "TextChangedP", "CmdlineChanged" }, -- ← カンマ必須
		cmdlineSources = {
			["/"] = { "around" },
			["?"] = { "around" },
		},
		sourceOptions = {
			_ = {
				-- matchers = { "matcher_head" },
				-- sorters = { "sorter_rank" },
				minAutoCompleteLength = 2,
				ignoreCase = true,
			},
			around = { mark = "[Ard]" },
			buffer = { mark = "[Buf]" },
			file = {
				mark = "[File]",
				isVolatile = true,
				forceCompletionPattern = "\\S/\\S*",
			}, -- ← 閉じとカンマ
			cmdline = { mark = "[Cmd]" },
		},
		sourceParams = {
			around = { maxSize = 500 },
			buffer = { requireSameFiletype = false },
		},
	})

	-- グローバルの既定ソース
	vim.fn["ddc#custom#patch_global"]("sources", { "around", "buffer" })
end

local function setup_ddc_buffer_sources()
	vim.fn["ddc#custom#patch_buffer"]("sources", { "nvim-lsp", "around", "buffer" })
	vim.fn["ddc#custom#patch_buffer"]("sourceOptions", {
		["nvim-lsp"] = {
			mark = "[LSP]",
			forceCompletionPattern = "\\.\\w*|:|->\\w*",
		},
	})
end

-- Denops 準備後に ddc を起動（これが本命）
vim.api.nvim_create_autocmd("User", {
	pattern = "DenopsReady",
	once = true,
	callback = function()
		setup_ddc_global_options()
		vim.fn["ddc#enable_cmdline_completion"]()
		vim.fn["ddc#enable"]()
		vim.notify("[ddc] enabled", vim.log.levels.INFO)
	end,
})

-- （保険）VimEnter 時、まだ未初期化なら起動
vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		if vim.fn.exists("*ddc#enable") == 1 and vim.fn["ddc#_initialized"]() ~= 1 then
			setup_ddc_global_options()
			pcall(vim.fn["ddc#enable_cmdline_completion"])
			pcall(vim.fn["ddc#enable"])
		end
	end,
})

-- LSP が付いたときだけ LSP ソースを足す（存在チェック付き）
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("DdcLspAttachConfig", { clear = true }),
	callback = function(args)
		if vim.bo[args.buf].filetype ~= "" and has_lsp_source() then
			setup_ddc_buffer_sources()
		end
	end,
})

-- ===== 補完メニュー操作 =====
-- Enterで確定（メニュー表示時のみ確定に切替）
vim.keymap.set("i", "<CR>", function()
	if vim.fn.pumvisible() == 1 then
		return vim.fn["pum#map#confirm"]()
	else
		return vim.api.nvim_replace_termcodes("<CR>", true, true, true)
	end
end, { expr = true, noremap = true })

-- 候補ナビゲーション（任意）
vim.keymap.set("i", "<Tab>", function()
	if vim.fn.pumvisible() == 1 then
		return "<Cmd>call pum#map#select_relative(+1)<CR>"
	end
	return "<Tab>"
end, { expr = true, noremap = true })

vim.keymap.set("i", "<S-Tab>", function()
	if vim.fn.pumvisible() == 1 then
		return "<Cmd>call pum#map#select_relative(-1)<CR>"
	end
	return "<S-Tab>"
end, { expr = true, noremap = true })

-- 手動トリガ（補完を明示開始）
vim.keymap.set("i", "<C-Space>", function()
	return vim.fn["ddc#map#manual_complete"]()
end, { expr = true, noremap = true })
