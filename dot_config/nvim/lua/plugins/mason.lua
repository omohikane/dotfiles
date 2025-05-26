-- lua/plugins/mason.lua

return function()
  local ok_mason, mason = pcall(require, "mason")
  if not ok_mason then
    vim.notify("mason.nvim の読み込みに失敗しました", vim.log.levels.ERROR)
    return
  end

  local ok_mason_lsp, mason_lspconfig = pcall(require, "mason-lspconfig")
  if not ok_mason_lsp then
    vim.notify("mason-lspconfig の読み込みに失敗しました", vim.log.levels.ERROR)
    return
  end

  local ok_lspconfig, lspconfig = pcall(require, "lspconfig")
  if not ok_lspconfig then
    vim.notify("lspconfig の読み込みに失敗しました", vim.log.levels.ERROR)
    return
  end

  mason.setup()

  mason_lspconfig.setup {
    ensure_installed = {
      "lua_ls",
      "pyright",
      "tsserver",
      "bashls",
      "jsonls",
      "yamlls",
      "dockerls",
      "taplo",
      "marksman",
    },
  }

  mason_lspconfig.setup_handlers {
    function(server_name)
      local ok, config = pcall(require, "lsp." .. server_name)
      if ok then
        lspconfig[server_name].setup(config)
      else
        vim.notify("LSP 設定 'lsp/" .. server_name .. ".lua' が見つかりません", vim.log.levels.WARN)
      end
    end,
  }
end

