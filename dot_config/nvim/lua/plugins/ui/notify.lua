return {
	"rcarriga/nvim-notify",
	config = function()
		-- From existing lua/plugins/notify.lua
		vim.notify = require("notify")
		require("notify").setup({
			stages = "fade",
			timeout = 3000,
			top_down = true,
		})
	end,
}
