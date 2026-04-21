-- lua/config/neotree.lua
local M = {}

function M.setup()
	local ok, neotree = pcall(require, "neo-tree")
	if not ok then
		return
	end

	neotree.setup({
		close_if_last_window = true,
		popup_border_style = "rounded",
		sources = { "filesystem", "buffers", "git_status", "diagnostics" },
		source_selector = { winbar = true },
		window = {
			position = "left",
			width = 34,
			mappings = {
				["s"] = "open_vsplit",
				["S"] = "open_split",
				["t"] = "open_tabnew",
				["R"] = "refresh",
				["H"] = "toggle_hidden",
			},
		},
		filesystem = {
			bind_to_cwd = true,
			follow_current_file = { enabled = true },
			use_libuv_file_watcher = true,
			filtered_items = {
				visible = false,
				hide_gitignored = true,
				hide_dotfiles = false,
			},
		},
	})
end

return M
