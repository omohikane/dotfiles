-- lua/plugins/ibl.lua
local M = {}
function M.setup()
  local ok, ibl = pcall(require, "ibl"); if not ok then return end

  local candidates = { "▏", "│", "┆", "|" }
  local function pick_char()
    for _, c in ipairs(candidates) do
      if vim.fn.strdisplaywidth(c) <= 1 then return c end
    end
    return "|"
  end
  local ch = pick_char()

  ibl.setup({
    indent = { char = ch, tab_char = ch },
    scope  = { enabled = true, show_start = false, show_end = false },
    exclude = {
      filetypes = { "help", "neo-tree", "TelescopePrompt", "gitcommit" },
      buftypes  = { "terminal", "nofile", "quickfix", "prompt" },
    },
  })
end
return M

