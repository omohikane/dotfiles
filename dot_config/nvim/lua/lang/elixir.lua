-- lua/lang/elixir.lua
local M = {}

function M.setup()
	local ok, elixir = pcall(require, "elixir")
	if not ok then
		return
	end

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	pcall(function()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
	end)

	elixir.setup({
		nextls = { enable = false },
		elixirls = {
			enable = true,
			cmd = (function()
				local exe = vim.fn.exepath("elixir-ls")
				return (exe ~= "" and { exe } or { "elixir-ls" })
			end)(),
			settings = {
				elixirLS = {
					dialyzerEnabled = false,
					fetchDeps = false,
				},
			},
			capabilities = capabilities,
			on_attach = function(_, bufnr)
				local map = function(m, lhs, rhs, desc)
					vim.keymap.set(m, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
				end
				map("n", "gd", vim.lsp.buf.definition, "LSP: Definition")
				map("n", "K", vim.lsp.buf.hover, "LSP: Hover")
			end,
		},
	})
end

return M
