-- lua/lsp/bashls.lua

local config = require("lsp.config")

return {
  name = "bashls",
  cmd = { "bash-language-server", "start" },
  on_attach = config.on_attach,
  capabilities = config.capabilities,
  filetypes = { "sh" },
  root_dir = vim.fs.dirname(vim.fs.find({ ".git", ".bashrc", ".zshrc" }, { upward = true })[1]),
}

