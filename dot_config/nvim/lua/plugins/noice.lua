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
		progress = { enabled = true },
	},

	messages = {
		enabled = true,
		view = "notify",
		view_error = "notify",
		view_warn = "notify",
		view_history = "messages",
		view_search = "virtualtext",
	},

	cmdline = {
		enabled = true,
		view = "cmdline_popup",
		format = {
			cmdline = {},
			search_down = {},
			search_up = {},
			filter = {},
			lua = {},
			help = {},
		},
	},

	views = {
		cmdline_popup = {
			border = {
				--				style = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				style = "none",
			},
			position = {
				row = 5,
				col = "50%",
			},
			size = {
				width = 60,
				height = "auto",
			},
			win_options = {
				winhighlight = { Normal = "Normal", FloatBorder = "FloatBorder" },
			},
		},
		popupmenu = {
			relative = "editor",
			position = {
				row = 8,
				col = "50%",
			},
			size = {
				width = 60,
				height = 10,
			},
			border = {
				-- style = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
				style = "none",
			},
			win_options = {
				winhighlight = { Normal = "Normal", FloatBorder = "FloatBorder" },
			},
		},
	},

	presets = {
		bottom_search = true,
		command_palette = true,
		long_message_to_split = true,
		inc_rename = false,
		lsp_doc_border = true,
	},
})
