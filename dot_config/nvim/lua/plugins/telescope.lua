-- lua/plugins/telescope.lua
local M = {}

function M.setup()
  local ok, telescope = pcall(require, "telescope")
  if not ok then return end

  local actions = require("telescope.actions")
  telescope.setup({
    defaults = {
      layout_strategy = "flex",
      sorting_strategy = "ascending",
      layout_config = { prompt_position = "top" },
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-q>"] = function(...)
            actions.smart_send_to_qflist(...); actions.open_qflist(...)
          end,
          ["<Esc>"] = actions.close,
        },
      },
      path_display = { "smart" },
    },
    pickers = {
      find_files = { hidden = true },
      buffers    = { sort_lastused = true, ignore_current_buffer = true },
    },
  })
end

return M

