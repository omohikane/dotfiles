-- plugins/mini_pairs.lua
local M = {}
function M.setup()
  local ok, mp = pcall(require, "mini.pairs"); if not ok then return end
  mp.setup()
end

return M
