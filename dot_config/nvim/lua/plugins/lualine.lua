-- lua/plugins/lualine.lua
local M = {}

function M.setup()
  local ok, lualine = pcall(require, "lualine"); if not ok then return end
  lualine.setup({
    options = { theme = 'auto', globalstatus = true, icons_enabled = true },
    sections = {
      lualine_a = {'mode'},
      lualine_b = {'branch', 'diff'},
      lualine_c = {'filename'},
      lualine_x = {'encoding','fileformat','filetype'},
      lualine_y = {'progress'},
      lualine_z = {'location'},
    },
  })
end

return M

