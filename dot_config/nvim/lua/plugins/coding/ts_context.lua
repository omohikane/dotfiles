return {
	"nvim-treesitter/nvim-treesitter-context",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	event = "BufReadPost",
	config = function()
		-- From existing lua/plugins/ts_context.lua
		require("treesitter-context").setup({
			enable = true,
			max_lines = 0,
			min_window_height = 0,
			line_numbers = true,
			multiline_threshold = 20,
			trim_scope = "outer",
			mode = "cursor",
			separator = nil,
			zindex = 20,
		})
	end,
}
