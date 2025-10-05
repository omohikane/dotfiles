-- plugins/mini_surround.lua
local M = {}
function M.setup()
  local ok, ms = pcall(require, "mini.surround"); if not ok then return end
  ms.setup({
    mappings = {
      add = "ys",
      delete = "ds",
      replace = "cs",
      find = "sf",
      find_left = "sF",
      highlight = "sh",
      update_n_lines = "sn",
      visual = "S",
      suffix_last = "l",
      suffix_next = "n",
    },
  })
end

return M
