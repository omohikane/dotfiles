-- Enable vim.loader
vim.loader.enable()

-- Define the path to lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- Clone lazy.nvim if it's not already installed
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

-- Prepend lazy.nvim to runtime path
vim.opt.rtp:prepend(lazypath)

-- Load lazy.nvim and configure plugins
require("lazy").setup({
  -- Coc.nvim
  {
    'neoclide/coc.nvim',
    branch = 'release',
    config = function()
      -- Automatically install coc extensions if they are not already installed
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          -- Use vim.fn.system to install extensions
          local coc_extensions = {"coc-json", "coc-tsserver"}
          for _, ext in ipairs(coc_extensions) do
            local is_installed = vim.fn.system({"sh", "-c", "nvim --headless +\"CocList -I extensions|grep " .. ext .. "\" +qa"})
            if not string.find(is_installed, ext) then
              vim.fn.system({"nvim", "--headless", "+CocInstall " .. ext, "+qa"})
            end
          end
        end
      })
    end
  },
  -- Noice.nvim
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify", -- OPTIONAL: For notifications
    }
  },
  -- Basic Markdown support
  {
    'plasticboy/vim-markdown',
    dependencies = { 'godlygeek/tabular' },
    config = function()
      vim.g.vim_markdown_folding_disabled = 1
      vim.g.vim_markdown_new_list_item_indent = 0
    end
  },
  -- Markdown preview
  {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && npm install',
    config = function()
      vim.g.mkdp_auto_start = 1
    end,
    ft = {'markdown'}
  },
  -- Diagram support
  'zhaozg/vim-diagram',

  -- Shell script support
  -- Syntax highlighting and indent
  {
    'sheerun/vim-polyglot'
  },
  -- LSP support
  {
    'neovim/nvim-lspconfig',
    config = function()
      require('lspconfig').bashls.setup{}
    end
  },
  -- Lint and formatter
  {
    'dense-analysis/ale',
    config = function()
      vim.g.ale_linters = {
        sh = {'shellcheck'}
      }
      vim.g.ale_fixers = {
        sh = {'shfmt'}
      }
      vim.g.ale_fix_on_save = 1
    end
  },
  -- Auto completion
  {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
      'saadparwaiz1/cmp_luasnip',
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets'
    },
    config = function()
      local cmp = require'cmp'
      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
          { name = 'cmdline' }
        }
      })
    end
  },
  -- File tree
  {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      require'nvim-tree'.setup {}
      vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
    end
  },
  -- Status line
  {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'gruvbox',
          section_separators = '',
          component_separators = ''
        }
      }
    end
  },
  -- Fuzzy Finder
  {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup {}
      vim.api.nvim_set_keymap('n', '<Leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<Leader>fg', ':Telescope live_grep<CR>', { noremap = true, silent = true })
    end
  },
  -- Colorscheme
  {
    'morhetz/gruvbox',
    config = function()
      vim.cmd('colorscheme gruvbox')
    end
  },
  -- Essential dependencies
  {
    'nvim-lua/plenary.nvim'
  }
})

-- Additional Keybindings and Options
vim.api.nvim_set_keymap('n', '<Leader>mdp', ':MarkdownPreview<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>mps', ':MarkdownPreviewStop<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>mpo', ':MarkdownPreviewToggle<CR>', { noremap = true, silent = true })

-- Set tab width to 2 spaces
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Enable line numbers
vim.opt.number = true

-- Additional recommended settings
-- Enable relative line numbers
vim.opt.relativenumber = true

-- Enable auto and smart indent
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Search settings
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Highlight current line
vim.opt.cursorline = true

-- Folding settings
vim.opt.foldmethod = 'indent'
vim.opt.foldlevel = 99

-- Disable backup and swap files
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Clipboard integration
vim.opt.clipboard = 'unnamedplus'

