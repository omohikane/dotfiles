-- lua/lsp/jsonls.lua

local config = require("lsp.config")

return {
  name = "jsonls",
  cmd = { "vscode-json-languageserver", "--stdio" },
  on_attach = config.on_attach,
  capabilities = config.capabilities,
  filetypes = { "json", "jsonc" },
}

