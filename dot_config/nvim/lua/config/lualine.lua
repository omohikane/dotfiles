-- lua/config/lualine.lua
local M = {}

function M.setup()
	local ok, lualine = pcall(require, "lualine")
	if not ok then
		return
	end

	lualine.setup({
		options = {
			theme = "auto",
			globalstatus = true,
			component_separators = { left = "", right = "" },
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },
			lualine_c = { { "filename", path = 1 } },
			lualine_x = {
				{
					function()
						local pok, skkeleton = pcall(require, "config.skkeleton")
						if pok and skkeleton.mode_status then
							return skkeleton.mode_status()
						end
						return ""
					end,
					color = { fg = "#ff9e64", gui = "bold" },
				},
				"encoding",
				"fileformat",
				"filetype",
			},
			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
	})
end

return M
