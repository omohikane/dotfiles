-- plugins/ddc.lua

local function ddc_has_native_ui()
	local base = vim.fn.stdpath("cache") .. "/dpp"
	local repo = base .. "/repos/github.com/Shougo/ddc-ui-native/denops/@ddc-uis/native.ts"
	local snap = base .. "/nvim/.dpp/denops/@ddc-uis/native.ts"
	return vim.fn.filereadable(repo) == 1 or vim.fn.filereadable(snap) == 1
end

local function setup_ddc_global_options()
	local ui_name = ddc_has_native_ui() and "native" or "pum"
	vim.fn["ddc#custom#patch_global"]({
		ui = ui_name,
		autoCompleteEvents = { "InsertEnter", "TextChangedI", "TextChangedP", "CmdlineChanged" },
		cmdlineSources = {
			["/"] = { "around" },
			["?"] = { "around" },
		},
		sourceOptions = {
			_ = {
				matchers = { "matcher_head" },
				sorters = { "sorter_rank" },
				minAutoCompleteLength = 2,
				ignoreCase = true,
			},
			around = { mark = "[Ard]" },
			buffer = { mark = "[Buf]" },
			file = { mark = "[File]", isVolatile = true, forceCompletionPattern = "\\S/\\S*" },
			cmdline = { mark = "[Cmd]" },
		},
		sourceParams = {
			around = { maxSize = 500 },
			buffer = { requireSameFiletype = false },
		},
	})

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

vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		if vim.fn.exists("*ddc#enable") == 1 then
			if vim.fn["ddc#_initialized"]() ~= 1 then
				setup_ddc_global_options()
				pcall(vim.fn["ddc#enable_cmdline_completion"])
				pcall(vim.fn["ddc#enable"])
			end
		end
	end,
})

local function has_lsp_source()
	return vim.fn.globpath(vim.o.rtp, "denops/@ddc-sources/nvim-lsp.ts") ~= ""
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("DdcLspAttachConfig", { clear = true }),
	callback = function(args)
		if vim.bo[args.buf].filetype ~= "" and has_lsp_source() then
			setup_ddc_buffer_sources()
		end
	end,
})

local function pum_visible()
	if vim.fn.exists("*ddc#ui#pum#visible") == 1 then
		return vim.fn["ddc#ui#pum#visible"]() == 1
	end
	return false
end

vim.keymap.set("i", "<Tab>", function()
	return pum_visible() and "<C-n>" or "<Tab>"
end, { expr = true, noremap = true })

vim.keymap.set("i", "<S-Tab>", function()
	return pum_visible() and "<C-p>" or "<C-h>"
end, { expr = true, noremap = true })

vim.keymap.set("i", "<C-j>", function()
	return pum_visible() and "<CR>"
		or (vim.fn.col(".") <= 1 or vim.fn.getline("."):sub(vim.fn.col(".") - 1, vim.fn.col(".") - 1):match("%s")) and "<Tab>"
		or vim.fn["ddc#map#manual_complete"]()
end, { expr = true, noremap = true })

vim.keymap.set("i", "<C-k>", function()
	return pum_visible() and "<C-p>" or ""
end, { expr = true, noremap = true })
