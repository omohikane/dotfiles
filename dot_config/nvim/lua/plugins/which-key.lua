-- plugins/which-key.lua

return function()
  local ok, wk = pcall(require, "which-key")
  if not ok then
    vim.notify("which-key.nvim が読み込めませんでした", vim.log.levels.ERROR)
    return
  end

  -- Setup
  wk.setup {
    plugins = {
      spelling = { enabled = true },
    },
    win = {
      border = "single",  -- deprecated: "window" → "win" に修正済み
      position = "bottom",
    },
    layout = {
      align = "center"
    }
  }

  -- Register groups for which-key
  wk.register({
  { "<leader>f", group = "file" },
  { "<leader>b", group = "buffer" },
  { "<leader>g", group = "git" },
  { "<leader>t", group = "terminal" },
  })

  -- Define keymaps with descriptions
  local map = vim.keymap.set
  local opts = { noremap = true, silent = true }

  -- File
  map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", vim.tbl_extend("force", opts, { desc = "Find File" }))
  map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>",   vim.tbl_extend("force", opts, { desc = "Recent Files" }))

  -- Buffer
  map("n", "<leader>bn", "<cmd>enew<cr>",                 vim.tbl_extend("force", opts, { desc = "New Buffer" }))
  map("n", "<leader>bd", "<cmd>bdelete<cr>",              vim.tbl_extend("force", opts, { desc = "Delete Buffer" }))

  -- Git
  map("n", "<leader>gs", "<cmd>GinStatus<cr>",            vim.tbl_extend("force", opts, { desc = "Git Status" }))

  -- Terminal
  map("n", "<leader>tt", "<cmd>ToggleTerm<cr>",           vim.tbl_extend("force", opts, { desc = "Toggle Terminal" }))
end

