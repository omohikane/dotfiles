require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
    adaptive_size = true,
  },
  renderer = {
    group_empty = true,
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    },
  },
  filters = {
    dotfiles = false,
  },
  git = {
    enable = true,
    ignore = false,
  },
  actions = {
    open_file = {
      quit_on_open = false,
    },
  },
})

vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>e", ":NvimTreeFocus<CR>", { noremap = true, silent = true })

