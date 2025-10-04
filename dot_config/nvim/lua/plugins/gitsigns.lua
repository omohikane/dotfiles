-- lua/plugins/gitsigns.lua
local M = {}

function M.setup()
  local ok, gs = pcall(require, "gitsigns")
  if not ok then return end

  gs.setup({
    signs = { add = { text = "▎" }, change = { text = "▎" }, delete = { text = "󰍵" },
              topdelete = { text = "󰍵" }, changedelete = { text = "▎" } },
    signcolumn = true,
    current_line_blame = true,
  })

  local map = function(mode, lhs, rhs, desc) vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc }) end
  map("n", "]c", gs.next_hunk, "Git: Next hunk")
  map("n", "[c", gs.prev_hunk, "Git: Prev hunk")
  map("n", "<Leader>gs", gs.stage_hunk, "Git: Stage hunk")
  map("n", "<Leader>gr", gs.reset_hunk, "Git: Reset hunk")
  map("n", "<Leader>gb", gs.toggle_current_line_blame, "Git: Toggle blame")
end

return M

