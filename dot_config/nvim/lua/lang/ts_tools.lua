-- lua/plugins/ts_tools.lua
local M = {}

function M.setup()
	local ok, tts = pcall(require, "typescript-tools")
	if not ok then
		return
	end

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	pcall(function()
		capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
	end)

	tts.setup({
		capabilities = capabilities,
		settings = {
			separate_diagnostic_server = true,
			publish_diagnostic_on = "insert_leave",
			complete_function_calls = true,
			tsserver_max_memory = "auto",
			jsx_close_tag = { enable = true },
		},
	})
end

return M
