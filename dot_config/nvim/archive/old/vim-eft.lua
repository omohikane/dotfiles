-- plugins/vim-eft.lua

-- f/F/t/T の挙動を強化
vim.keymap.set("n", "f", "<Plug>(eft-f)", { silent = true })
vim.keymap.set("n", "F", "<Plug>(eft-F)", { silent = true })
vim.keymap.set("n", "t", "<Plug>(eft-t)", { silent = true })
vim.keymap.set("n", "T", "<Plug>(eft-T)", { silent = true })

-- repeat に対応（`;`, `,` の挙動を拡張）
vim.keymap.set("n", ";", "<Plug>(eft-repeat)", { silent = true })
vim.keymap.set("n", ",", "<Plug>(eft-repeat-opposite)", { silent = true })

