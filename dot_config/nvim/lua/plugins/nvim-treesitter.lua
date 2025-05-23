require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "lua", "vim", "bash", "markdown",
    "python", "javascript", "typescript",
    "json", "yaml", "toml"
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
    disable = {"markdown"},
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      node_incremental = "<CR>",
      node_decremental = "<BS>",
      scope_incremental = "<TAB>",
    },
  },
  autopairs = {
    enable = true
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  }
})

