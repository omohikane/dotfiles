-- lua/config/lspconfig.lua
local M = {}

function M.setup()
	local ok, lspconfig = pcall(require, "lspconfig")
	if not ok then
		return
	end

	-- Capabilities for nvim-cmp
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	local cmp_ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
	if cmp_ok then
		capabilities = cmp_lsp.default_capabilities(capabilities)
	end

	-- Add foldingRange capability for nvim-ufo
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}

	-- Global on_attach
	local on_attach = function(client, bufnr)
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = "LSP: " .. desc })
		end
		map("n", "gd", vim.lsp.buf.definition, "Definition")
		map("n", "gD", vim.lsp.buf.declaration, "Declaration")
		map("n", "gr", vim.lsp.buf.references, "References")
		map("n", "gi", vim.lsp.buf.implementation, "Implementation")
		map("n", "K", function()
			local winid = require("ufo").peekFoldedLinesUnderCursor()
			if not winid then
				vim.lsp.buf.hover()
			end
		end, "Hover or Peek Fold")
		map("n", "<Leader>rn", vim.lsp.buf.rename, "Rename")
		map("n", "<Leader>ca", vim.lsp.buf.code_action, "Code Action")

		-- Diagnostic navigation
		map("n", "[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
		map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")

		-- Inlay Hints
		if client.server_capabilities.inlayHintProvider then
			map("n", "<Leader>th", function()
				local current = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
				vim.lsp.inlay_hint.enable(not current, { bufnr = bufnr })
			end, "Toggle Inlay Hints")
		end
	end

	-- Server Configurations
	local servers = {
		bashls = { cmd_env = { SHELL = vim.env.SHELL } },
		cssls = {},
		html = {},
		jsonls = {},
		marksman = {},
		pyright = {},
		rust_analyzer = {}, -- Added for Rust
		yamlls = {
			settings = { yaml = { keyOrdering = false, format = { enable = true }, validate = true } },
		},
		lua_ls = {
			settings = {
				Lua = {
					runtime = { version = "LuaJIT" },
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
						checkThirdParty = false,
					},
					diagnostics = { globals = { "vim" } },
					completion = { callSnippet = "Replace" },
					telemetry = { enable = false },
					hint = { enable = true },
					format = { enable = false },
				},
			},
		},
		terraformls = {},
		ts_ls = {
			settings = {
				typescript = { inlayHints = { includeInlayParameterNameHints = "all" } },
				javascript = { inlayHints = { includeInlayParameterNameHints = "all" } },
			},
		},
	}

	for server, config in pairs(servers) do
		local merged_config = vim.tbl_deep_extend("force", {
			on_attach = on_attach,
			capabilities = capabilities,
		}, config)

		-- Neovim 0.11/0.12+ recommended way
		if vim.lsp.config then
			vim.lsp.config(server, merged_config)
			vim.lsp.enable(server)
		else
			-- Fallback for older versions (just in case)
			lspconfig[server].setup(merged_config)
		end
	end
end

return M
