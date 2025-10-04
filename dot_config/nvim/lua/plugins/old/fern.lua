-- plugins/fern.lua

vim.api.nvim_set_keymap("n", "<Leader>f", ":Fern . -drawer -reveal=% -toggle<CR>", { noremap = true, silent = true })

-- require('fern-renderer-devicons').setup{}

