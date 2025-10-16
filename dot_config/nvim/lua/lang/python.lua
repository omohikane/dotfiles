local M = {}

function M.setup()
	local ok, lspconfig = pcall(require, "lspconfig")
	if ok then
		lspconfig.pyright.setup({})
	end

	pcall(function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = vim.tbl_deep_extend("force", conform.formatters_by_ft or {}, {
				python = { "black", "isort" },
			}),
		})
	end)

	pcall(function()
		local lint = require("lint")
		lint.linters_by_ft = vim.tbl_deep_extend("force", lint.linters_by_ft or {}, {
			python = { "ruff" },
		})
	end)
end

return M
