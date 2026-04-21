-- lua/config/noice.lua
local M = {}

function M.setup()
	local ok, noice = pcall(require, "noice")
	if not ok then
		return
	end

	noice.setup({
		cmdline = {
			view = "cmdline", -- Force command line to the bottom
		},
		search = {
			view = "cmdline", -- Force search to the bottom
		},
		lsp = {
			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.set_id_for_markdown_lines"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		-- you can enable a preset for easier configuration
		presets = {
			long_message_to_split = true, -- long messages will be sent to a split
			inc_rename = false, -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = true, -- add a border to hover docs and signature help
		},
		messages = {
			enabled = true,
			view = "notify", -- default view for messages
			view_error = "notify", -- view for errors
			view_warn = "notify", -- view for warnings
			view_history = "messages", -- view for :messages
			view_search = "virtualtext", -- view for search count messages. set to `false` to disable
		},
	})
end

return M
