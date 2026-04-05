return {
	"lewis6991/gitsigns.nvim",
	event = "BufReadPost",
	config = function()
		-- From existing lua/plugins/gitsigns.lua
		require("gitsigns").setup({
			signs = {
				add = { text = "│" },
				change = { text = "│" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
			signcolumn = true,
			numhl = false,
			linehl = false,
			word_diff = false,
			watch_gitdir = { follow_files = true },
			attach_to_untracked = true,
			current_line_blame = false,
		})
	end,
}
