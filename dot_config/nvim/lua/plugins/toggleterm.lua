-- lua/plugins/toggleterm.lua
local M = {}

function M.setup()
  local ok, toggleterm = pcall(require, "toggleterm")
  if not ok then return end
  toggleterm.setup({
    open_mapping = [[<C-\>]],   
    shade_terminals = true,
    start_in_insert = true,
    shell = "fish"
    direction = "float",
    float_opts = { border = "rounded" },
  })

  vim.cmd([[
    tnoremap <Esc> <C-\><C-n>
    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l
  ]])
end

function M.lazygit()
  if vim.fn.executable("lazygit") == 0 then
    vim.notify("[toggleterm] lazygit not found", vim.log.levels.WARN)
    return
  end
  local Terminal = require("toggleterm.terminal").Terminal
  Terminal:new({ cmd = "lazygit", direction = "float", hidden = true }):toggle()
end

return M

