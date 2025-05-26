-- lua/plugins/trouble.lua
require("trouble").setup({
  position = "bottom",
  height = 10,
  icons = true,
  fold_open = "",
  fold_closed = "",
  signs = {
    error = "",
    warning = "",
    hint = "",
    information = "",
    other = "",
  },
  use_diagnostic_signs = true,
})

vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { desc = "Toggle Trouble" })
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Workspace Diagnostics" })
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Document Diagnostics" })
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { desc = "Location List" })
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { desc = "Quickfix List" })

