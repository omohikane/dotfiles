return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	cmd = "Neotree",
	dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim", "nvim-tree/nvim-web-devicons" },
	config = function()
		-- From existing lua/plugins/neotree.lua
		vim.g.neo_tree_remove_legacy_commands = 1
		require("neo-tree").setup({
			close_if_last_window = true,
			popup_border_style = "rounded",
			sources = { "filesystem", "buffers", "git_status" },
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
	end,
}
