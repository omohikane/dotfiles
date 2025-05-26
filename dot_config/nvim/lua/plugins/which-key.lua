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
    ["<leader>"] = {
      b = {
        name = "buffer",
        d = { "<cmd>bdelete<cr>", "Delete Buffer" },
        n = { "<cmd>enew<cr>", "New Buffer" },
      },
      f = {
        name = "file",
        ff = { "<cmd>Telescope find_files<cr>", "Find File" },
        fr = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
      },
      g = {
        name = "git",
        gs = { "<cmd>GinStatus<cr>", "Git Status" },
      },
      t = {
        name = "terminal",
        tt = { "<cmd>ToggleTerm<cr>", "Toggle Terminal" },
      },
    },
  })
end

