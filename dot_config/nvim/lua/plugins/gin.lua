-- plugins/gin.lua

-- GinStatus をトグル起動
vim.api.nvim_set_keymap("n", "<Leader>gs", ":GinStatus<CR>", { noremap = true, silent = true })

-- GinLog のサンプル
vim.api.nvim_set_keymap("n", "<Leader>gl", ":GinLog<CR>", { noremap = true, silent = true })

-- GinDiff（対象ファイルに限定）
vim.api.nvim_set_keymap("n", "<Leader>gd", ":GinDiff<CR>", { noremap = true, silent = true })

