return {
	"unblevable/quick-scope",
	event = "VeryLazy",
	init = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "TelescopePrompt", "neo-tree", "help" },
			callback = function()
				vim.cmd("silent! QuickScopeDisable")
			end,
		})
	end,
}
