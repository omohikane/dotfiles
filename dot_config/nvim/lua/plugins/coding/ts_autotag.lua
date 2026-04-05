return {
	"windwp/nvim-ts-autotag",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	event = { "BufReadPost", "InsertEnter" },
	config = function()
		-- From existing lua/plugins/ts_autotag.lua
		require("nvim-ts-autotag").setup({
			opts = {
				enable_close = true,
				enable_rename = true,
				enable_close_on_slash = true,
			},
		})
	end,
}
