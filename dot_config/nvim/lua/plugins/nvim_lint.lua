-- plugins/nvim_lint.lua

local M = {}
function M.setup()
  local ok, lint = pcall(require, "lint"); if not ok then return end

  local has = function(exe) return vim.fn.executable(exe) == 1 end
  lint.linters_by_ft = {
    lua        = has("luacheck") and { "luacheck" } or nil,
    sh         = has("shellcheck") and { "shellcheck" } or nil,
    python     = has("ruff") and { "ruff" } or nil,
    javascript = has("eslint_d") and { "eslint_d" } or nil,
    typescript = has("eslint_d") and { "eslint_d" } or nil,
    go         = has("golangci_lint") or nil,
    rust       = has("clippy") or nil,
    elixir     = has("credo") or nil,
    yaml       = has("yamllint") and { "yamllint" } or nil,
  }

  local aug = vim.api.nvim_create_augroup("OjouNvimLint", { clear = true })
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    group = aug,
    callback = function() require("lint").try_lint() end,
  })
end

return M
