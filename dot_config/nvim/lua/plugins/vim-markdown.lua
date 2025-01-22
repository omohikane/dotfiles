-- Basic Markdown support
-- plugins/vim-markdown.lua
return {
    'plasticboy/vim-markdown',
    dependencies = { 'godlygeek/tabular' },
    config = function()
        -- 基本設定
        vim.g.vim_markdown_folding_disabled = 1        
        vim.g.vim_markdown_new_list_item_indent = 0    
        vim.g.vim_markdown_auto_insert_bullets = 1     
        vim.g.vim_markdown_frontmatter = 1             
        vim.g.vim_markdown_strikethrough = 1           
        vim.g.vim_markdown_math = 1                    
        vim.g.vim_markdown_conceal = 0                 
    end,
    ft = {'markdown'}  
}

