-- lua/plugins/fidget.lua
local M = {}

function M.setup()
  local ok, fidget = pcall(require, "fidget"); if not ok then return end
  fidget.setup({
    progress = {
      suppress_on_insert = true,      
      ignore = { },                   
      display = {
        render_limit = 6,             
        done_ttl = 1.0,               
      },
    },
    notification = {
      window = { border = "rounded", winblend = 10 }, 
    },
    logger = { level = vim.log.levels.WARN }, 
  })
end

return M

