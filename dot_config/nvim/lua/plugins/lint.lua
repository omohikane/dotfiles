-- lua/plugins/lint.lua

local lint = require("lint")

lint.linters_by_ft = {
  lua = { "luacheck" },
  python = { "flake8" },
  javascript = { "eslint" },
  typescript = { "eslint" },
  sh = { "shellcheck" },
  markdown = { "markdownlint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    lint.try_lint()
  end,
})

-- key mapping
vim.keymap.set("n", "<leader>L", function()
  lint.try_lint()
end, { desc = "Run Linter" })

