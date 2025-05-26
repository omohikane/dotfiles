-- lua/lsp/pyright.lua

local config = require("lsp.config")

return {
  name = "pyright",
  cmd = { "pyright-langserver", "--stdio" },
  on_attach = config.on_attach,
  capabilities = config.capabilities,
  filetypes = { "python" },
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "basic",
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
      },
    },
  },
}

