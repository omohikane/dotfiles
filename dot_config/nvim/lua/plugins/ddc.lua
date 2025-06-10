-- plugins/ddc.lua

local function setup_ddc_global_options()
	vim.fn["ddc#custom#patch_global"]({
		ui = "native",
		autoCompleteEvents = {
			"InsertEnter",
			"TextChangedI",
			"TextChangedP",
			"CmdlineChanged",
		},
		cmdlineSources = {
			[":"] = { "cmdline_history" },
			["/"] = { "around" },
			["?"] = { "around" },
		},
		sourceOptions = {
			_ = {
				matchers = { "matcher_head", "matcher_fuzzy" },
				sorters = { "sorter_rank" },
				converters = { "converter_remove_overlap" },
				minAutoCompleteLength = 2,
				ignoreCase = true,
			},
			around = { mark = "[Ard]" },
			buffer = { mark = "[Buf]" },
			file = { mark = "[File]", isVolatile = true, forceCompletionPattern = "\\S/\\S*" },
			cmdline = { mark = "[Cmd]" },
			["cmdline_history"] = { mark = "[Hist]" },
		},
		sourceParams = {
			around = { maxSize = 500 },
			buffer = { requireSameFiletype = false },
		},
	})
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
		vim.fn["ddc#custom#patch_global"]("sources", { "around", "buffer" })
		vim.fn["ddc#custom#patch_source"]("_", {
			matchers = { "matcher_head" },
			sorters = { "sorter_rank" },
		})
		vim.fn["ddc#enable"]()
		vim.notify("[ddc] Global settings applied and ddc enabled.", vim.log.levels.INFO)
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("DdcLspAttachConfig", { clear = true }),
	callback = function(args)
		if vim.bo[args.buf].filetype ~= "" then
			setup_ddc_buffer_sources()
		end
	end,
})

-- 補完用のキーマッピング（pum可視性のチェック修正済）
local function pum_visible()
	-- Check if the function exists before calling it
	if vim.fn.exists("*ddc#ui#pum#visible") == 1 then
		return vim.fn["ddc#ui#pum#visible"]() == 1
		-- For ddc.vim 5.0+, it might be pum#visible()
		-- elseif vim.fn.exists("*pum#visible") == 1 then
		--  return vim.fn["pum#visible"]() == 1
	end
	return false
end

vim.keymap.set("i", "<Tab>", function()
	if pum_visible() then
		return "<C-n>" -- 補完候補を次に移動
	else
		-- 補完候補が表示されていない場合は、単にタブを挿入
		return "<Tab>"
	end
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
