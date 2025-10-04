-- lua/plugins/toggleterm.lua

return function()
  local ok, toggleterm = pcall(require, "toggleterm")
  if not ok then
    vim.notify("toggleterm.nvim の読み込みに失敗しましたわ", vim.log.levels.ERROR)
    return
  end

  toggleterm.setup {
    shell = "fish",
    direction = "float",
    float_opts = {
      border = "curved",
    },
    open_mapping = [[<C-\>]]
  }
end

