return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = "Trouble",
	init = function()
		local map = vim.keymap.set
		map("n", "<Leader>xx", "<Cmd>Trouble diagnostics toggle<CR>", { silent = true })
		map("n", "<Leader>xq", "<Cmd>Trouble qflist toggle<CR>", { silent = true })
	end,
	config = function()
		-- From existing lua/plugins/trouble.lua
		require("trouble").setup({
			position = "bottom",
			height = 10,
			icons = true,
			mode = "workspace_diagnostics",
		})
	end,
}
