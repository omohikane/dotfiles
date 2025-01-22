-- plugins/nvim-treesitter
return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = {
                "lua", "vim", "bash", "markdown",
                "python", "javascript", "typescript",
                "json", "yaml", "toml"
            },
            
            -- highlight
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },

            -- indent
            indent = {
                enable = true
            },

            -- increment 
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<CR>',
                    node_incremental = '<CR>',
                    node_decremental = '<BS>',
                    scope_incremental = '<TAB>',
                },
            },

            --  auto pairs
            autopairs = {
                enable = true
            },

            -- context-comment
            context_commentstring = {
                enable = true,
                enable_autocmd = false,
            }
        })
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'windwp/nvim-ts-autotag',
    }
}

