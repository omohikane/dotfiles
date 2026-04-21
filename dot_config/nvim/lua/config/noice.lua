-- lua/config/noice.lua
local M = {}

function M.setup()
	local ok, noice = pcall(require, "noice")
	if not ok then
		return
	end

	noice.setup({
		cmdline = {
			view = "cmdline_popup",
		},
		search = {
			view = "cmdline_popup",
		},
		views = {
			cmdline_popup = {
				position = {
					row = 2, -- Top area
					col = "50%",
				},
				size = {
					width = 60,
					height = "auto",
				},
			},
			popupmenu = {
				relative = "editor",
				position = {
					row = 5, -- Near the command line
					col = "50%",
				},
				size = {
					width = 60,
					height = 10,
				},
				border = {
					style = "rounded",
					padding = { 0, 1 },
				},
				win_options = {
					winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
				},
			},
		},
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.set_id_for_markdown_lines"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		presets = {
			long_message_to_split = true,
			lsp_doc_border = true,
		},
	})
end

return M
