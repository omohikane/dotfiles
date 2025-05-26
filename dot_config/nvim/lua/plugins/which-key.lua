-- lua/plugins/which-key.lua

return function()
  local ok, wk = pcall(require, "which-key")
  if not ok then
    vim.notify("which-key.nvim が読み込めませんでした", vim.log.levels.ERROR)
    return
  end

  wk.setup({
    plugins = {
      spelling = { enabled = true },
    },
    win = {
      border = "single",
    },
    layout = {
      align = "center",
    },
  })

wk.register({
  { "<leader>f", group = "file" },
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File" },
  { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
  { "<leader>b", group = "buffer" },
  { "<leader>bd", "<cmd>bdelete<cr>", desc = "Delete Buffer" },
  { "<leader>bn", "<cmd>enew<cr>", desc = "New Buffer" },
  { "<leader>g", group = "git" },
  { "<leader>gs", "<cmd>GinStatus<cr>", desc = "Git Status" },
  { "<leader>t", group = "terminal" },
  { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
})

end

