return {
	"elixir-tools/elixir-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	ft = { "elixir", "eelixir", "heex", "surface" },
	config = function()
		-- From existing lua/lang/elixir.lua
		local elixir = require("elixir")
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		local cmp_lsp_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
		if cmp_lsp_ok then
			capabilities = cmp_lsp.default_capabilities(capabilities)
		end

		-- Neovim 0.11+ Modern LSP Setup for Elixir
		vim.lsp.config("elixirls", {
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
		})
		vim.lsp.enable("elixirls")

		elixir.setup({
			nextls = { enable = false },
			elixirls = { enable = false }, -- Handled by vim.lsp.config above
		})
	end,
}
