return {
	"epwalsh/obsidian.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	cmd = { "ObsidianQuickSwitch", "ObsidianNew", "ObsidianToday", "ObsidianOpen" },
	config = function()
		-- From existing lua/plugins/obsidian.lua
		require("obsidian").setup({
			workspaces = {
				{ name = "personal", path = "~/obsidian/personal" },
				{ name = "work", path = "~/obsidian/work" },
			},
			daily_notes = {
				folder = "dailies",
				date_format = "%Y-%m-%d",
				alias_format = "%B %-d, %Y",
				template = nil,
			},
			completion = { nvim_cmp = true, min_chars = 2 },
			mappings = {
				["gf"] = {
					action = function()
						return require("obsidian").util.gf_passthrough()
					end,
					opts = { noremap = false, expr = true, buffer = true },
				},
				["<leader>ch"] = {
					action = function()
						return require("obsidian").util.toggle_checkbox()
					end,
					opts = { buffer = true },
				},
			},
		})
	end,
}
