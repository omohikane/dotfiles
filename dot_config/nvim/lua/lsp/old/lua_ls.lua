-- lua/lsp/lua_ls.lua

local config = require("lsp.config")

return {
  name = "lua_ls",
  cmd = { "lua-language-server" },
  on_attach = config.on_attach,
  capabilities = config.capabilities,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        checkThirdParty = false,
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

