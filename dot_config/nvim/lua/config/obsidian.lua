-- lua/config/obsidian.lua
local M = {}

function M.setup()
	local ok, obsidian = pcall(require, "obsidian")
	if not ok then
		return
	end

	obsidian.setup({
		workspaces = {
			{
				name = "vault",
				path = "~/GitHub/r1ppl3s-obsidian-notes",
			},
		},
		completion = {
			nvim_cmp = true,
		},
		mappings = {
			["gf"] = {
				action = function()
					return obsidian.util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true },
			},
		},
	})
end

return M
