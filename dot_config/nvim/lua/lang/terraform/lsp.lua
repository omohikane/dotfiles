-- lua/lang/terraform/lsp.lua

local ok, lspconfig = pcall(require, "lspconfig")
if not ok then return end

lspconfig.terraformls.setup({
  filetypes = { "terraform", "terraform-vars", "tf", "tfvars" },
})
