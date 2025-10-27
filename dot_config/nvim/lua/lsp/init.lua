-- /home/ripple/.config/nvim/lua/lsp/init.lua

local M = {}

function M.setup()
  -- すべてのプラグインが読み込まれた後に実行することで、タイミングの問題を回避する
  vim.schedule(function()
    -- LSPとCmpの連携に必要な共通設定を読み込む
    local lsp_common = require("lsp.config")
    local on_attach = lsp_common.on_attach
    local capabilities = lsp_common.capabilities

    local lspconfig = require("lspconfig")

    -- 各サーバーを個別にセットアップ
    lspconfig.bashls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
    lspconfig.cssls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
    lspconfig.html.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
    lspconfig.jsonls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
        },
      },
    })
    lspconfig.marksman.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
    lspconfig.pyright.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
    lspconfig.ts_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
    lspconfig.yamlls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })
  end)
end

return M