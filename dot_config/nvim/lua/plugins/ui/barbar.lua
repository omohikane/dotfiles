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

		-- 🧹 バッファ整理 (整理・掃除)
		map("n", "<Leader>bo", "<Cmd>BufferCloseAllButCurrent<CR>", { desc = "現在のバッファ以外をすべて閉じる", silent = true })
		map("n", "<Leader>bp", "<Cmd>BufferCloseAllButPinned<CR>", { desc = "ピン留め以外をすべて閉じる", silent = true })
		map("n", "<Leader>bsd", "<Cmd>BufferOrderByDirectory<CR>", { desc = "ディレクトリ順に並び替え", silent = true })
		map("n", "<Leader>bsl", "<Cmd>BufferOrderByLanguage<CR>", { desc = "言語順に並び替え", silent = true })
	end,
	config = function()
		-- From existing lua/plugins/barbar.lua
		require("barbar").setup({})
	end,
}
