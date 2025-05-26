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
      position = "bottom",
    },
    layout = {
      align = "center",
    },
  })

  -- keymap registration in recommended format
  wk.register({
    ["<leader>"] = {
      f = {
        name = "+file",
        f = { "<cmd>Telescope find_files<cr>", "Find File" },
        r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
      },
      b = {
        name = "+buffer",
        n = { "<cmd>enew<cr>", "New Buffer" },
        d = { "<cmd>bdelete<cr>", "Delete Buffer" },
      },
      g = {
        name = "+git",
        s = { "<cmd>GinStatus<cr>", "Git Status" },
      },
      t = {
        name = "+terminal",
        t = { "<cmd>ToggleTerm<cr>", "Toggle Terminal" },
      },
    },
  })
end

