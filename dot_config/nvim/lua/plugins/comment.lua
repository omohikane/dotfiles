-- /plugins/comment.lua
local M = {}
function M.setup()
  local ok, Comment = pcall(require, "Comment"); if not ok then return end
  Comment.setup({
    mappings = { basic = true, extra = true },
  })
end

return M
