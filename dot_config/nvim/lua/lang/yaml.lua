local M = {}

function M.setup()
	local ok, lspconfig = pcall(require, "lspconfig")
	if ok then
		lspconfig.yamlls.setup({
			settings = {
				yaml = {
					keyOrdering = false,
					format = { enable = true },
					validate = true,
				},
			},
		})
	end

	pcall(function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = vim.tbl_deep_extend("force", conform.formatters_by_ft or {}, {
				yaml = { "yamlfmt" },
			}),
		})
	end)

	pcall(function()
		local lint = require("lint")
		lint.linters_by_ft = vim.tbl_deep_extend("force", lint.linters_by_ft or {}, {
			yaml = { "yamllint" },
		})
	end)
end

return M
