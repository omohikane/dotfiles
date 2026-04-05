return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	event = "BufReadPost",
	config = function()
		-- From existing lua/plugins/ibl.lua
		require("ibl").setup({
			indent = { char = "|" },
			scope = { enabled = false },
		})
	end,
}
