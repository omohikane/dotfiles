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

end

