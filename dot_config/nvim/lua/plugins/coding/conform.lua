return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	config = function()
		-- From existing lua/plugins/conform.lua
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				javascriptreact = { { "prettierd", "prettier" } },
				typescriptreact = { { "prettierd", "prettier" } },
				go = { "gofmt", "goimports" },
				rust = { "rustfmt" },
				elixir = { "mix" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		})
	end,
}
