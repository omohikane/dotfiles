-- plugins/ddc.lua

local function setup_ddc_global_options()
	-- グローバルな ddc 設定 (UI や基本的な挙動)
	vim.fn["ddc#custom#patch_global"]({
		ui = "native", -- または "pum" など、好みのUI
		autoCompleteEvents = {
			"InsertEnter",
			"TextChangedI",
			"TextChangedP",
			"CmdlineChanged",
		},
		cmdlineSources = {
			":",
			{ name = "cmdline", params = {}},
			{ name = "cmdline-history", params = {}},
		},
		sourceOptions = {
			_ = { -- デフォルトのソースオプション
				matchers = { "matcher_head", "matcher_fuzzy" },
				sorters = { "sorter_rank", "sorter_fuzzy" },
				converters = { "converter_remove_overlap", "converter_fuzzy" },
				minAutoCompleteLength = 2,
				ignoreCase = true,
			},
			around = { mark = "[Ard]" },
			buffer = { mark = "[Buf]" },
			file = { mark = "[File]" , isVolatile = true, forceCompletionPattern = "\\S/\\S*" },
			cmdline = { mark = "[Cmd]" },
			["cmdline-history"] = { mark = "[Hist]" },
		},
		sourceParams = {
			around = { maxSize = 500 },
			buffer = { requireSameFiletype = false },
		},
	})
end

local function setup_ddc_buffer_sources()
	-- バッファローカルなソース設定 (LSPがアタッチされた場合)
	vim.fn["ddc#custom#patch_buffer"]("sources", { "nvim-lsp", "around", "buffer" })
	-- nvim-lsp 用の sourceOptions もここで設定
	vim.fn["ddc#custom#patch_buffer"]("sourceOptions", {
		["nvim-lsp"] = {
			mark = "[LSP]",
			forceCompletionPattern = "\\.\\w*|:\\w*|->\\w*",
			-- kindLabels = vim.lsp.protocol.CompletionItemKind, -- 必要に応じて
		},
	})
	vim.cmd("echomsg '[ddc] DEBUG: Attempted to patch buffer sources with nvim-lsp for buffer " .. vim.api.nvim_get_current_buf() .. "'") -- デバッグ用メッセージ
	vim.notify("[ddc] nvim-lsp source enabled for this buffer.", vim.log.levels.INFO)
end

-- DenopsReady イベントでグローバル設定とコマンドライン補完を有効化
vim.api.nvim_create_autocmd("User", {
	pattern = "DenopsReady",
	once = true,
	callback = function()
		setup_ddc_global_options()
		vim.fn["ddc#enable_cmdline_completion"]()
		-- LSPがアタッチされないバッファのためのデフォルトソース
		vim.fn["ddc#custom#patch_global"]("sources", { "around", "buffer", "file" })
		vim.fn["ddc#enable"]() -- ddc をグローバルに有効化
		vim.notify("[ddc] Global settings applied and ddc enabled.", vim.log.levels.INFO)
	end,
})

-- LspAttach イベントでバッファローカルなソースを設定
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("DdcLspAttachConfig", { clear = true }),
	callback = function(args)
		-- args.buf を使って特定のバッファでのみ設定することも可能
		if vim.bo[args.buf].filetype ~= "" then -- filetype がある場合のみ
			setup_ddc_buffer_sources()
		end
	end,
})

-- キーマッピング (変更なし、ただし pum#visible() の代わりに ddc#pum#visible() を検討)
-- ddc.vim は独自のポップアップメニュー (PUM) を持つため、
-- vim.fn["pum#visible"]() は期待通りに動作しない可能性があります。
-- ddc.vim のドキュメントで推奨される PUM の可視性チェック方法を確認してください。
-- 多くの場合 vim.fn["ddc#pum#visible"]() や vim.fn["ddc#ui#pum#visible"]() などになります。
-- 以下は現在のキーマッピングを維持しつつ、コメントを追加したものです。

-- キーマッピング
-- 注意: pum#visible() は ddc.vim の PUM と互換性がない可能性があります。
-- ddc.vim のドキュメントで推奨される PUM 可視性チェック関数 (例: ddc#pum#visible()) を使用してください。
vim.keymap.set("i", "<Tab>", function()
	return vim.fn["ddc#pum#visible"]() and "<C-n>"
		or (vim.fn.col(".") <= 1 or vim.fn.getline("."):sub(vim.fn.col(".") - 1, vim.fn.col(".") - 1):match("%s")) and "<Tab>"
		or vim.fn["ddc#map#manual_complete"]()
end, { expr = true, noremap = true })

vim.keymap.set("i", "<S-Tab>", [[vim.fn["ddc#pum#visible"]() ? '<C-p>' : '<C-h>']], { expr = true, noremap = true })

vim.keymap.set("i", "<C-j>", function()
	return vim.fn["ddc#pum#visible"]() and "<Space>" -- または <CR> で確定など、お好みに合わせて
		or (vim.fn.col(".") <= 1 or vim.fn.getline("."):sub(vim.fn.col(".") - 1, vim.fn.col(".") - 1):match("%s")) and "<Tab>"
		or vim.fn["ddc#map#manual_complete"]()
end, { expr = true, noremap = true })

vim.keymap.set("i", "<C-k>", [[vim.fn["ddc#pum#visible"]() ? '<C-p>' : '']], { expr = true, noremap = true })
-- 以下の重複したキーマッピングブロックは削除されました
			matchers = { "matcher_head" },
			sorters = { "sorter_rank" },
			converters = {},
		}
	}
})
