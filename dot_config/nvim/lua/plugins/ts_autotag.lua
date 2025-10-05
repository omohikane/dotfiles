-- plugins/ts_autotag.lua
local M = {}

function M.setup()
  local ok, autotag = pcall(require, "nvim-ts-autotag")
  if not ok then return end

  autotag.setup({
    -- enable_close            = true,
    -- enable_rename           = true,
    -- enable_close_on_slash   = true,
    -- filetypes = { "html", "xml", "javascriptreact", "typescriptreact", "vue", "svelte", "astro" },
    -- skip_tags = { "area", "base", "br", "col", "embed", "hr", "img", "input", "link", "meta", "param", "source", "track", "wbr" },
  })
end

return M

