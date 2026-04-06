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
							local ok, skk = pcall(require, "plugins.tools.skkeleton")
							if ok and skk.mode_status then
								return skk.mode_status()
							end
							return ""
						end,
						cond = function()
							return vim.fn.exists("*skkeleton#mode") == 1
						end,
						color = function()
							local mode = vim.fn["skkeleton#mode"]()
							if mode == "hira" or mode == "kata" or mode == "zenkaku" then
								return { fg = "#ff9e64", gui = "bold" } -- アクティブ時は明るいオレンジ
							else
								return { fg = "#7aa2f7" } -- 英数時は落ち着いたブルー
							end
						end,
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
