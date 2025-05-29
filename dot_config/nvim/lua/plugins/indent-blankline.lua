-- plugins/indent-blankline.lua

return {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	config = function()
		require("ibl").setup({
			indent = {
				char = "│",
			},
			scope = {
				enabled = true,
				show_start = true,
				show_end = true,
				highlight = { "Function", "Label" },
			},
			exclude = {
				filetypes = { "help", "dashboard", "NvimTree", "lazy" },
				buftypes = { "terminal", "nofile" },
			},
		})
	end,
}
