-- キーマッピング設定
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Markdownプレビュー
keymap('n', '<Leader>mdp', ':MarkdownPreview<CR>', opts)
keymap('n', '<Leader>mps', ':MarkdownPreviewStop<CR>', opts)
keymap('n', '<Leader>mpo', ':MarkdownPreviewToggle<CR>', opts)

