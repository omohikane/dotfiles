-- lua/lsp/yamlls.lua
local config = require("lsp.config")

return {
  name = "yamlls",
  cmd = { "yaml-language-server", "--stdio" },
  on_attach = config.on_attach,
  capabilities = config.capabilities,
  settings = {
    yaml = {
      validate = true,
      hover = true,
      completion = true,
    },
  },
}

