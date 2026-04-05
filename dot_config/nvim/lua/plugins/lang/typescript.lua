return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	config = function()
		-- From existing lua/plugins/ts_tools.lua
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		require("typescript-tools").setup({
			on_attach = function(_, bufnr)
				local map = function(m, lhs, rhs, desc)
					vim.keymap.set(m, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
				end
				map("n", "gd", vim.lsp.buf.definition, "LSP: Definition")
			end,
			capabilities = capabilities,
			settings = {
				expose_as_code_action = "all",
				tsserver_file_preferences = {
					includeInlayParameterNameHints = "all",
					includeInlayVariableTypeHints = true,
				},
			},
		})
	end,
}
