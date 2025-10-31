-- lua/lsp/init.lua

local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
do
	local ok, cmp = pcall(require, "cmp_nvim_lsp")
	if ok then
		capabilities = cmp.default_capabilities(capabilities)
	end
end

local function on_attach(_, bufnr)
	local map = function(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
	end
	map("n", "gd", vim.lsp.buf.definition, "LSP: Definition")
	map("n", "gr", vim.lsp.buf.references, "LSP: References")
	map("n", "gi", vim.lsp.buf.implementation, "LSP: Implementation")
	map("n", "K", vim.lsp.buf.hover, "LSP: Hover")
	map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: Rename")
	map("n", "<leader>ca", vim.lsp.buf.code_action, "LSP: Code Action")
	map("n", "<leader>cf", function()
		vim.lsp.buf.format({ async = true })
	end, "LSP: Format")
end

local function enable(server, cfg)
	local config = vim.lsp.config(
		server,
		vim.tbl_deep_extend("force", {
			on_attach = on_attach,
			capabilities = capabilities,
		}, cfg or {})
	)
	vim.lsp.enable(server, config)
end

function M.setup()
	enable("bashls", { cmd_env = { SHELL = vim.env.SHELL } })
	enable("cssls", {})
	enable("html", {})
	enable("jsonls", {})
	enable("marksman", {})
	enable("pyright", {})
	enable("yamlls", {
		settings = { yaml = { keyOrdering = false, format = { enable = true }, validate = true } },
	})
	enable("lua_ls", {
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
					checkThirdParty = false,
				},
				diagnostics = {},
				completion = { callSnippet = "Replace" },
				telemetry = { enable = false },
				hint = { enable = true },
				format = { enable = false },
			},
		},
	})
	enable("terraformls", {})
end

return M
