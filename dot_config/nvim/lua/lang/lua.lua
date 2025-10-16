local M = {}

function M.setup()
	local ok, lspconfig = pcall(require, "lspconfig")
	if ok then
		lspconfig.lua_ls.setup({
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					workspace = { checkThirdParty = false },
					telemetry = { enable = false },
				},
			},
		})
	end

	pcall(function()
		local conform = require("conform")
		conform.setup({
			formatters_by_ft = vim.tbl_deep_extend("force", conform.formatters_by_ft or {}, {
				lua = { "stylua" },
			}),
		})
	end)
end

return M
