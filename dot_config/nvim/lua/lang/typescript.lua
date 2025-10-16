local M = {}

function M.setup()
	-- LSP
	local ok, lspconfig = pcall(require, "lspconfig")
	if ok then
		lspconfig.tsserver.setup({
			settings = {
				typescript = { inlayHints = { includeInlayParameterNameHints = "all" } },
				javascript = { inlayHints = { includeInlayParameterNameHints = "all" } },
			},
		})
	end

	-- Formatter（conform）
	pcall(function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = vim.tbl_deep_extend("force", conform.formatters_by_ft or {}, {
				javascript = { "prettierd", "prettier" },
				javascriptreact = { "prettierd", "prettier" },
				typescript = { "prettierd", "prettier" },
				typescriptreact = { "prettierd", "prettier" },
				json = { "jq" },
			}),
		})
	end)

	-- Linter（nvim-lint）
	pcall(function()
		local lint = require("lint")
		lint.linters_by_ft = vim.tbl_deep_extend("force", lint.linters_by_ft or {}, {
			javascript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescript = { "eslint_d" },
			typescriptreact = { "eslint_d" },
		})
	end)
end

return M
