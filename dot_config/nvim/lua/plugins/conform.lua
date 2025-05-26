-- lua/plugins/conform.lua

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    json = { "prettier" },
    markdown = { "markdownlint" },
    sh = { "shfmt" },
  },
  format_on_save = {
    lsp_fallback = true,
    timeout_ms = 500,
  },
})

