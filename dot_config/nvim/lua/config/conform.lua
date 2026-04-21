-- lua/config/conform.lua
local M = {}

function M.setup()
	local ok, conform = pcall(require, "conform")
	if not ok then
		return
	end

	conform.setup({
		formatters_by_ft = {
			lua = { "stylua" },
			sh = { "shfmt" },
			bash = { "shfmt" },
			python = { "ruff_format", "black", "isort" },
			javascript = { "prettierd", "prettier" },
			typescript = { "prettierd", "prettier" },
			javascriptreact = { "prettierd", "prettier" },
			typescriptreact = { "prettierd", "prettier" },
			go = { "goimports", "gofumpt", "golines" },
			rust = { "rustfmt" },
			elixir = { "mix" },
			json = { "jq", "prettier" },
			yaml = { "prettier" },
			html = { "prettier" },
			css = { "prettier" },
			markdown = { "prettier" },
		},
		format_on_save = function(bufnr)
			return { timeout_ms = 1500, lsp_fallback = true }
		end,
	})

	vim.keymap.set("n", "<Leader>cf", function()
		conform.format({ async = false, lsp_fallback = true })
	end, { desc = "Format buffer" })
end

return M
