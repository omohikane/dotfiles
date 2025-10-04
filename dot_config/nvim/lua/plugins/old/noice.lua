local ok, noice = pcall(require, "noice")
if not ok then
	vim.notify("Noice not loaded", vim.log.levels.WARN)
	return
end

noice.setup({
	cmdline = {
		enabled = true,
		view = "cmdline",
	},
	messages = {
		enabled = false,
		view = "notify",
	},
	popupmenu = {
		enabled = true,
		view = "cmp",
	},
	lsp = {
		progress = {
			enabled = false,
		},
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	views = {
		mini = {
			backend = "popup",
			relative = "editor",
			position = {
				row = "100%",
				col = "50%",
			},
			size = {
				width = 60,
				height = "auto",
			},
			border = {
				style = "none",
			},
		},
		cmdline_popup = {
			position = {
				row = 5,
				col = "50%",
			},
			size = {
				width = 60,
				height = "auto",
			},
			border = {
				style = "none",
			},
			win_options = {
				winhighlight = {
					Normal = "NormalFloat",
					FloatBorder = "FloatBorder",
				},
			},
		},
	},
	presets = {
		bottom_search = true, -- / の検索を下部に表示
		command_palette = true, -- コマンド入力を中央に表示
		long_message_to_split = true, -- 長文はスプリットに
		inc_rename = false, -- :IncRename のプラグインを使わないなら false
		lsp_doc_border = true, -- LSP ヘルプに枠をつける
	},
})
