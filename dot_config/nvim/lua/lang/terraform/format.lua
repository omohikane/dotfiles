-- lua/lang/terraform/format.lua
local ok, conform = pcall(require, "conform")
if not ok then return end

conform.setup({
  formatters_by_ft = vim.tbl_deep_extend("force",
    conform.formatters_by_ft or {},
    {
      terraform      = { "terraform_fmt" },
      ["terraform-vars"] = { "terraform_fmt" },
      hcl            = { "terraform_fmt" },
    }
  ),
})

