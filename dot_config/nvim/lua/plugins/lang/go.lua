return {
	"ray-x/go.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"neovim/nvim-lspconfig",
		"nvim-lua/plenary.nvim",
	},
	ft = "go",
	config = function()
		local go = require("go")
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		local cmp_lsp_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
		if cmp_lsp_ok then
			capabilities = cmp_lsp.default_capabilities(capabilities)
		end

		-- Neovim 0.11+ Modern LSP Setup for Go
		vim.lsp.config("gopls", {
			capabilities = capabilities,
			settings = {
				gopls = {
					usePlaceholders = true,
					staticcheck = true,
					analyses = { unusedparams = true },
				},
			},
		})
		vim.lsp.enable("gopls")

		-- go.nvim Setup (Disable internal lsp_cfg to avoid deprecation warning)
		go.setup({
			lsp_cfg = false, -- We handle it via vim.lsp.config above
			lsp_inlay_hints = { enable = true },
			gofmt = "gofumpt",
			goimport = "gopls",
			trouble = false,
		})

		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.go",
			callback = function()
				require("go.format").gofmt()
			end,
		})
	end,
}
