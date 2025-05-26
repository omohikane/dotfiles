-- lua/lsp/tsserver.lua

local config = require("lsp.config")

return {
  name = "tsserver",
  cmd = { "typescript-language-server", "--stdio" },
  on_attach = config.on_attach,
  capabilities = config.capabilities,
  filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" },
  root_dir = vim.fs.dirname(vim.fs.find({ "package.json", "tsconfig.json", ".git" }, { upward = true })[1]),
}

