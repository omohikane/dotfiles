-- lua/plugins/scratch.lua

require("scratch").setup({})

vim.keymap.set("n", "<leader>sb", function()
	require("scratch").open()
end, { desc = "📝 Open scratch buffer" })
