local M = {}
function M.setup()
  local ok, ctx = pcall(require, "treesitter-context"); if not ok then return end
  ctx.setup({
    enable = true,
    max_lines = 3,
    multiline_threshold = 4,
    mode = "cursor",
    separator = "-",
  })
end
return M

