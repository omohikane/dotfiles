-- lua/plugins/barbar.lua
local M = {}

function M.setup()
  local ok, barbar = pcall(require, 'barbar')
  if not ok then return end

  barbar.setup({
    sidebar_filetypes = {
      ['neo-tree'] = { event = 'BufWipeout' },
    },
    auto_hide = false,
    icons = {
      preset = 'default',
      diagnostics = { [vim.diagnostic.severity.ERROR] = { enabled = true } },
      separator = { left = '▎', right = '' },
    },
    insert_at_end = false,
  })
end

return M

