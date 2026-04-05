return {
	"lambdalisue/gin.vim",
	dependencies = { "vim-denops/denops.vim" },
	cmd = { "Gin", "GinStatus", "GinDiff", "GinLog", "GinBranch", "GinBrowse", "GinBlame" },
	init = function()
		local map = vim.keymap.set
		map("n", "<Leader>gg", "<Cmd>GinStatus<CR>", { silent = true })
		map("n", "<Leader>gc", "<Cmd>Gin commit<CR>", { silent = true })
		map("n", "<Leader>gl", "<Cmd>GinLog<CR>", { silent = true })
		map("n", "<Leader>gd", "<Cmd>GinDiff<CR>", { silent = true })
		map("n", "<Leader>gb", "<Cmd>GinBlame<CR>", { silent = true })
	end,
}
