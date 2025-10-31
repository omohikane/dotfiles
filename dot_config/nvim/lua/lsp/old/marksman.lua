-- lua/lsp/marksman.lua

local config = require("lsp.config")

return {
  name = "marksman",
  cmd = { "marksman", "server" },
  on_attach = config.on_attach,
  capabilities = config.capabilities,
  filetypes = { "markdown" },
}

