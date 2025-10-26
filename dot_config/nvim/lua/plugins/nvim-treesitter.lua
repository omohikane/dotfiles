-- lua/plugins/treesitter.lua
local M = {}

function M.setup()
	local ok, ts = pcall(require, "nvim-treesitter.configs")
	if not ok then
		return
	end

	ts.setup({
		highlight = { enable = true },
		indent = { enable = true },

		ensure_installed = {
			"lua",
			"vim",
			"vimdoc",
			"query",
			"bash",
			"json",
			"yaml",
			"toml",
			"html",
			"css",
			"javascript",
			"typescript",
			"tsx",
			"python",
			"markdown",
			"markdown_inline",
			"gitcommit",
			"gitignore",
			"regex",
			"rust",
		},
		auto_install = false,

		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "gnn",
				node_incremental = "grn",
				node_decremental = "grm",
				scope_incremental = "grc",
			},
		},
	})
end

return M
