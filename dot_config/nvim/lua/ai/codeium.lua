-- Disable default bindings
vim.g.codeium_disable_bindings = true

-- AI補完のキーマッピング
vim.keymap.set("i", "<C-g>", function()
	return vim.fn["codeium#Accept"]()
end, { expr = true, silent = true, desc = "Codeium: Accept suggestion" })

vim.keymap.set("i", "<C-;>", function()
	return vim.fn
end, { expr = true, silent = true, desc = "Codeium: Next suggestion" })

vim.keymap.set("i", "<C-,>", function()
	return vim.fn["codeium#CycleCompletions"](-1)
end, { expr = true, silent = true, desc = "Codeium: Previous suggestion" })

vim.keymap.set("i", "<C-x>", function()
	return vim.fn["codeium#Clear"]()
end, { expr = true, silent = true, desc = "Codeium: Clear suggestion" })
