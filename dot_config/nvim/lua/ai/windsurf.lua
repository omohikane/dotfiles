-- Disable default bindings
vim.g.windsurf_disable_bindings = true

-- AI補完のキーマッピング
vim.keymap.set("i", "<C-g>", function()
	return vim.fn["windsurf#Accept"]()
end, { expr = true, silent = true, desc = "windsurf: Accept suggestion" })

vim.keymap.set("i", "<C-;>", function()
	return vim.fn
end, { expr = true, silent = true, desc = "windsurf: Next suggestion" })

vim.keymap.set("i", "<C-,>", function()
	return vim.fn["windsurf#CycleCompletions"](-1)
end, { expr = true, silent = true, desc = "windsurf: Previous suggestion" })

vim.keymap.set("i", "<C-x>", function()
	return vim.fn["windsurf#Clear"]()
end, { expr = true, silent = true, desc = "windsurf: Clear suggestion" })
