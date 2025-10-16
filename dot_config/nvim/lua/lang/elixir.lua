local M = {}

function M.setup()
  local ok, elixir = pcall(require, "elixir")
  if not ok then return end
  local elixirls = require("elixir.elixirls")

  elixir.setup({
    nextls = { enable = false },
    elixirls = {
      enable = true,
      settings = elixirls.settings({
        dialyzerEnabled = false,
        fetchDeps = false,
      }),
      on_attach = function(client, bufnr)
      end,
      cmd = { "elixir-ls" },
    },
  })
end

return M
