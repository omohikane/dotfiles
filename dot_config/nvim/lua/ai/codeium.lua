-- lua/ai/codeium.lua

require("codeium").setup({
	enable_chat = false,
	tools = {
		keymaps = {
			accept = "<C-y>",
			next = "<C-n>",
			prev = "<C-p>",
			clear = "<C-x>",
		},
	},
})
