local M = {}

function M.setup()
  -- LSP
  require("lspconfig").gopls.setup({
    settings = {
      gopls = {
        gofumpt = true,
        staticcheck = true,
        analyses = { unusedparams = true, shadow = true },
      },
    },
  })

  local ok, go = pcall(require, "go")
  if ok then
    go.setup({
      lsp_cfg = false,
      trouble = true,
      lsp_inlay_hints = { enable = true },
    })
  end
end

return M
