-- lua/config/tobira.lua
local M = {}

function M.setup()
	local ok, tobira = pcall(require, "tobira")
	if not ok then
		return
	end

	tobira.setup({
		border = { '-', '/', '|', '\\' },
	})
end

return M
