-- lua/plugins/conform.lua
local M = {}

function M.setup()
  local ok, conform = pcall(require, "conform"); if not ok then return end

  conform.setup({
    formatters_by_ft = {
      lua             = { "stylua" },
      sh              = { "shfmt" },
      bash            = { "shfmt" },
      python          = { "ruff_format", "black" },
      javascript      = { "prettier" },
      typescript      = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      go              = { "gofumpt", "golines" },
      rust            = { "rustfmt" },
      elixir          = { "mix" },
      json            = { "prettier" },
      yaml            = { "prettier" },
      html            = { "prettier" },
      css             = { "prettier" },
      markdown        = { "prettier" },
    },

    format_on_save = function(bufnr)
      return { timeout_ms = 1500, lsp_fallback = true }
    end,
  })

  vim.keymap.set("n", "<Leader>f", function()
    conform.format({ async = false, lsp_fallback = true })
  end, { desc = "Format buffer" })
end

return M
