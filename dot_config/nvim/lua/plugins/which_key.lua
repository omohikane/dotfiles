-- lua/plugins/which-key.lua

local M = {}
function M.setup()
  local ok, wk = pcall(require, "which-key"); if not ok then return end
  wk.setup({})
  wk.add({
    { "<leader>f", group = "find" },
    { "<leader>g", group = "git" },
    { "<leader>x", group = "diagnostics" },
  })
end

return M
