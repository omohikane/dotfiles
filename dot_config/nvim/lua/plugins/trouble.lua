-- lua/plugins/trouble.lua

return function()
  local ok, trouble = pcall(require, "trouble")
  if not ok then
    vim.notify("trouble.nvim の読み込みに失敗しましたわ", vim.log.levels.ERROR)
    return
  end

  trouble.setup {
    position = "bottom",
    height = 10,
    icons = true,
    mode = "workspace_diagnostics",
    fold_open = "",
    fold_closed = "",
    use_diagnostic_signs = true
  }
end

