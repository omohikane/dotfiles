local M = {}

function M.setup()
	local ok, lspconfig = pcall(require, "lspconfig")
	if ok and lspconfig.marksman then
		lspconfig.marksman.setup({})
	end

	pcall(function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = vim.tbl_deep_extend("force", conform.formatters_by_ft or {}, {
				markdown = { "prettier" },
			}),
		})
	end)

	pcall(function()
		local lint = require("lint")
		lint.linters_by_ft = vim.tbl_deep_extend("force", lint.linters_by_ft or {}, {
			markdown = { "markdownlint" },
		})
	end)
end

return M
