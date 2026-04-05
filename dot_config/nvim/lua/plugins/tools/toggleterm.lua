return {
	"akinsho/toggleterm.nvim",
	cmd = "ToggleTerm",
	init = function()
		local map = vim.keymap.set
		map("n", "<Leader>tt", "<Cmd>ToggleTerm direction=float<CR>", { silent = true })
		map("n", "<Leader>tv", "<Cmd>ToggleTerm direction=vertical size=80<CR>", { silent = true })
		map("n", "<Leader>th", "<Cmd>ToggleTerm direction=horizontal size=12<CR>", { silent = true })
		map("n", "<Leader>tg", '<Cmd>lua require("plugins.tools.toggleterm").lazygit()<CR>', { silent = true })
	end,
	config = function()
		-- From existing lua/plugins/toggleterm.lua
		require("toggleterm").setup({
			open_mapping = [[<C-\>]],
			hide_numbers = true,
			shade_terminals = true,
			start_in_insert = true,
			insert_mappings = true,
			persist_size = true,
			direction = "float",
			close_on_exit = true,
			shell = vim.o.shell,
			float_opts = {
				border = "curved",
				winblend = 3,
			},
		})
	end,
	-- Added lazygit function directly if we move the file
	lazygit = function()
		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new({ cmd = "lazygit", hidden = true, direction = "float" })
		lazygit:toggle()
	end,
}
