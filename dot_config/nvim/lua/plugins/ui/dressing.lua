return {
	"stevearc/dressing.nvim",
	event = "VeryLazy",
	opts = {
		input = {
			enabled = true,
			default_prompt = "Input:",
			title_pos = "left",
			insert_only = true,
			start_in_insert = true,
			border = "rounded",
			relative = "cursor",
			prefer_width = 40,
			max_width = { 140, 0.9 },
			min_width = { 20, 0.2 },
		},
		select = {
			enabled = true,
			backend = { "telescope", "fzf_lua", "builtin", "nui" },
			trim_prompt = true,
			telescope = nil, -- Uses default telescope theme
		},
	},
}
