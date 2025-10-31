-- lua/lsp/cssls.lua

local config = require("lsp.config")

return {
  name = "cssls",
  cmd = { "vscode-css-language-server", "--stdio" },
  on_attach = config.on_attach,
  capabilities = config.capabilities,
  filetypes = { "css", "scss", "less" },
}

