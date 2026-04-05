return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "VeryLazy",
	config = function()
		-- From existing lua/plugins/lualine.lua
		require("lualine").setup({
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
							-- Note: ensure plugins.skkeleton is accessible or move logic
							local ok, skk = pcall(require, "plugins.tools.skkeleton")
							if ok and skk.mode_status then
								return skk.mode_status()
							end
							-- Fallback to old path if not moved yet or just call directly if available
							local ok2, skk2 = pcall(require, "plugins.skkeleton")
							if ok2 and skk2.mode_status then
								return skk2.mode_status()
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
	end,
}
