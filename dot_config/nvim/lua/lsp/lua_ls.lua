-- lua/lsp/lua_ls.lua
local config = require("lsp.config")

return {
  name = "lua_ls",
  cmd = { "lua-language-server" },
  on_attach = config.on_attach,
  capabilities = config.capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
      },
    },
  },
}

