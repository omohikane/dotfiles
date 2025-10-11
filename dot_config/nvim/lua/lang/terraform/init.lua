-- lua/lang/terraform/init.lua
local M = {}

function M.setup()
  pcall(require, "lang.terraform.lsp")
  pcall(require, "lang.terraform.lint")
  pcall(require, "lang.terraform.format")

  vim.defer_fn(function()
    pcall(vim.cmd, "silent! TSInstallSync hcl terraform")
  end, 100)
end

return M
