-- plugins/junkfile.lua

-- config
vim.g["junkfile#directory"] = vim.fn.expand("~/.junk/")
vim.g["junkfile#filename_format"] = "%Y%m%d-%H%M%S.txt"

-- Create directory
local junk_dir = vim.fn.expand("~/.junk/")
if vim.fn.isdirectory(junk_dir) == 0 then
	vim.fn.mkdir(junk_dir, "p")
end

-- command shortcut
vim.keymap.set("n", "<leader>jf", ":Junkfile<CR>", { noremap = true, silent = true, desc = "Open junk file" })
