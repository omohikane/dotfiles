-- lua/lsp/html.lua

local config = require("lsp.config")

return {
  name = "html",
  cmd = { "vscode-html-language-server", "--stdio" },
  on_attach = config.on_attach,
  capabilities = config.capabilities,
  filetypes = { "html" },
}

