return {
	"romgrk/barbar.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "lewis6991/gitsigns.nvim" },
	event = "VeryLazy",
	init = function()
		vim.g.barbar_auto_setup = false
		local map = vim.keymap.set
		map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", { silent = true })
		map("n", "<A-.>", "<Cmd>BufferNext<CR>", { silent = true })
		map("n", "<A-c>", "<Cmd>BufferClose<CR>", { silent = true })
		map("n", "<A-p>", "<Cmd>BufferPin<CR>", { silent = true })
		map("n", "<C-p>", "<Cmd>BufferPick<CR>", { silent = true })
	end,
	config = function()
		-- From existing lua/plugins/barbar.lua
		require("barbar").setup({})
	end,
}
