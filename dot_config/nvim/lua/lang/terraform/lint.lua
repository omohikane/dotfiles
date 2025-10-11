-- lua/lang/terraform/lint.lua
local ok, lint = pcall(require, "lint")
if not ok then return end

lint.linters_by_ft = vim.tbl_deep_extend("force",
  lint.linters_by_ft or {},
  {
    terraform      = { "tflint" },
    ["terraform-vars"] = { "tflint" },
  }
)

vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
  pattern = { "*.tf", "*.tfvars" },
  callback = function()
    require("lint").try_lint()
  end,
})

