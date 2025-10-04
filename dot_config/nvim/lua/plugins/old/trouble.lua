-- lua/plugins/trouble.lua

local trouble = require("trouble")

trouble.setup({
  position = "bottom",
  height = 10,
  icons = true,
  mode = "workspace_diagnostics",
  group = true,
  padding = true,
  action_keys = {
    close = "q",
    refresh = "r",
    jump = { "<cr>", "<tab>" },
  },
  auto_open = false,
  auto_close = false,
  auto_preview = true,
  signs = {
    error = "",
    warning = "",
    hint = "",
    information = "",
    other = "",
  },
  use_diagnostic_signs = false
})

-- 🔐 Key mappings
vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { desc = "Toggle Trouble Panel" })
vim.keymap.set("n", "<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", { desc = "Workspace Diagnostics" })
vim.keymap.set("n", "<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>", { desc = "Document Diagnostics" })
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { desc = "Quickfix List" })
vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { desc = "Location List" })
vim.keymap.set("n", "gr", "<cmd>TroubleToggle lsp_references<cr>", { desc = "LSP References (Trouble)" })

