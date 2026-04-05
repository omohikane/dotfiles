return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		-- From existing lua/plugins/which_key.lua
		require("which-key").setup({
			plugins = { spelling = { enabled = true } },
		})
	end,
}
