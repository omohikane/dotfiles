return {
	"numToStr/Comment.nvim",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		-- From existing lua/plugins/comment.lua
		require("Comment").setup({
			padding = true,
			sticky = true,
			ignore = nil,
			toggler = { line = "gcc", block = "gbc" },
			opleader = { line = "gc", block = "gb" },
			extra = { above = "gcO", below = "gco", eol = "gcA" },
			mappings = { basic = true, extra = true },
		})
	end,
}
