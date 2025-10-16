local M = {}

function M.setup()
	local ok, lspconfig = pcall(require, "lspconfig")
	if ok then
		lspconfig.bashls.setup({})
	end

	pcall(function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = vim.tbl_deep_extend("force", conform.formatters_by_ft or {}, {
				sh = { "shfmt" },
				bash = { "shfmt" },
			}),
		})
	end)

	pcall(function()
		local lint = require("lint")
		lint.linters_by_ft = vim.tbl_deep_extend("force", lint.linters_by_ft or {}, {
			sh = { "shellcheck" },
			bash = { "shellcheck" },
		})
	end)
end

return M
