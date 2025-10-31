-- lua/plugins/ts_tools.lua
local M = {}
function M.setup()
	local ok, tts = pcall(require, "typescript-tools")
	if not ok then
		return
	end

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	local ok_cmp, cmp = pcall(require, "cmp_nvim_lsp")
	if ok_cmp then
		capabilities = cmp.default_capabilities(capabilities)
	end

	tts.setup({
		capabilities = capabilities,
		settings = {
			separate_diagnostic_server = true,
			publish_diagnostic_on = "insert_leave",
			complete_function_calls = true,
			tsserver_max_memory = "auto",
		},
	})
end
return M
