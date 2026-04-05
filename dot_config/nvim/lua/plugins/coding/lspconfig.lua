return {
	"neovim/nvim-lspconfig",
	config = function()
		-- Neovim 0.11+ uses vim.lsp.config and vim.lsp.enable.
		-- This silences the deprecation warning from nvim-lspconfig.
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		vim.lsp.config("lua_ls", {
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					workspace = { checkThirdParty = false },
					telemetry = { enabled = false },
				},
			},
		})
		vim.lsp.enable("lua_ls")

		-- Also load your custom LSP directory logic (lua/lsp/init.lua)
		local ok, lsp_setup = pcall(require, "lsp")
		if ok and lsp_setup.setup then
			lsp_setup.setup()
		end
	end,
}
