-- lua/core/env.lua
local M = {}

function M.load(filepath)
	local file = io.open(filepath, "r")
	if not file then
		vim.notify("⚠ .env file not found: " .. filepath, vim.log.levels.WARN)
		return
	end

	for line in file:lines() do
		local key, value = line:match("^([%w_]+)%s*=%s*(.+)$")
		if key and value then
			vim.env[key] = value
		end
	end

	file:close()
end

return M
