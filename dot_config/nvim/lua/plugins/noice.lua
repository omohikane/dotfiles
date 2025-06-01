-- lua/plugins/noice.lua

local ok, noice = pcall(require, "noice")
if not ok then
	vim.notify("Noice not loaded", vim.log.levels.WARN)
	return
end

noice.setup({
	lsp = {
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
		progress = {
			enabled = true,
		},
	},
	messages = {
		enabled = true,
		view = "notify",
		view_error = "notify",
		view_warn = "notify",
	},
	cmdline = {
		enabled = true,
		view = "cmdline",
	},
	views = {
		cmdline = {
			position = {
				row = 0,
				col = 0,
			},
			size = {
				width = "100%",
				height = 1,
			},
		},
	},
	presets = {
		bottom_search = true,
		command_palette = true,
		long_message_to_split = false,
		inc_rename = false,
		lsp_doc_border = false,
	},
	defaults = { -- 追加: デフォルト設定を上書き
		view = {
			border = "single", -- すべてのビューのデフォルト境界線を "single" に変更
		},
	},
})
