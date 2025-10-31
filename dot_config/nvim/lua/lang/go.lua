-- lua/lang/go.lua
local M = {}

function M.setup()
	local ok, go = pcall(require, "go")
	if not ok then
		return
	end

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	pcall(function()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
	end)

	go.setup({
		lsp_cfg = {
			capabilities = capabilities,
			settings = {
				gopls = {
					usePlaceholders = true,
					staticcheck = true,
					analyses = { unusedparams = true },
				},
			},
		},
		lsp_inlay_hints = { enable = true },
		gofmt = "gofumpt",
		goimport = "gopls",
		trouble = false,
	})

	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = "*.go",
		callback = function()
			pcall(vim.lsp.buf.format, { async = false })
		end,
	})
end

return M
