i-- plugins/nvim-ts-autotag.lua

local present, autotag = pcall(require, "nvim-ts-autotag")
if not present then
  vim.notify("nvim-ts-autotag not found!", vim.log.levels.ERROR)
  return
end

autotag.setup({
  opts = {
    -- enable auto close and rename of HTML/JSX tags
    enable_close = true,
    enable_rename = true,
    enable_close_on_slash = false,
  },
  -- filetypes where this plugin should be enabled
  filetypes = {
    "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact",
    "svelte", "vue", "tsx", "jsx", "rescript",
    "php", "markdown"
  },
})

