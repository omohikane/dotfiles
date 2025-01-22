-- LSP support
-- plugins/lsp-support.lua
return {
    'neovim/nvim-lspconfig',
    dependencies = {
        'williamboman/mason.nvim',
        'williamboman/mason-lspconfig.nvim',
    },
    config = function()
        -- Mason（LSPマネージャー）の設定
        require('mason').setup()
        require('mason-lspconfig').setup({
            ensure_installed = {
                "lua_ls",    -- Lua
                "pyright",   -- Python
                "bashls",    -- Bash
            }
        })

        -- LSPの基本設定
        local lspconfig = require('lspconfig')
        
        -- キーマッピング
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help)

        -- 各言語サーバーの設定
        lspconfig.lua_ls.setup{}
        lspconfig.pyright.setup{}
        lspconfig.bashls.setup{}
    end
}

