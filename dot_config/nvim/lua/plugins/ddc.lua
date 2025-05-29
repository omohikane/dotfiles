-- plugins/ddc.lua

-- 補完ソースとフィルターを有効化する設定（Denops 経由）
vim.fn["ddc#custom#patch_global"]({
	sources = { "nvim-lsp", "around", "file", "cmdline" },
	sourceOptions = {
		["_"] = {
			matchers = { "matcher_head" },
			sorters = { "sorter_rank" },
			converters = { "converter_remove_overlap" },
		},
		["nvim-lsp"] = {
			mark = "lsp",
			forceCompletionPattern = "\\.\\w*|:\\w*|->\\w*",
		},
		["around"] = { mark = "A" },
		["file"] = { mark = "F" },
		["cmdline"] = { mark = "C" },
	},
	sourceParams = {
		["around"] = { maxSize = 500 },
	},
})

-- コマンドライン補完の有効化
vim.api.nvim_create_autocmd("User", {
	pattern = "DenopsReady",
	once = true,
	callback = function()
		vim.fn["ddc#enable_cmdline_completion"]()
	end,
})

-- インサートモード時に有効化
vim.api.nvim_create_autocmd("InsertEnter", {
	callback = function()
		vim.fn["ddc#enable"]()
	end,
})

-- ui setting
vim.fn["ddc#custom#patch_global"]({
	ui = "native",
	sources = { "nvim-lsp", "around", "buffer" },
	sourceOptions = {
		_ = {
			matchers = { "matcher_head" },
			sorters = { "sorter_rank" },
			converters = {},
		},
	},
})

-- キーマッピング
vim.keymap.set("i", "<Tab>", function()
	return vim.fn["pum#visible"]() == 1 and "<C-n>"
		or (vim.fn.col(".") <= 1 or vim.fn.getline("."):sub(vim.fn.col(".") - 1, vim.fn.col(".") - 1):match("%s")) and "<Tab>"
		or vim.fn["ddc#map#manual_complete"]()
end, { expr = true, noremap = true })

vim.keymap.set("i", "<S-Tab>", [[pum#visible() ? '<C-p>' : '<C-h>']], { expr = true, noremap = true })

-- <C-j>
vim.keymap.set("i", "<C-j>", function()
	return vim.fn["pum#visible"]() == 1 and "<Space>"
		or (vim.fn.col(".") <= 1 or vim.fn.getline("."):sub(vim.fn.col(".") - 1, vim.fn.col(".") - 1):match("%s")) and "<Tab>"
		or vim.fn["ddc#map#manual_complete"]()
end, { expr = true, noremap = true })

vim.keymap.set("i", "<C-k>", [[pum#visible() ? '<C-p>' : '']], { expr = true, noremap = true })
