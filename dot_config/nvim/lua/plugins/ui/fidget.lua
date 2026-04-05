return {
	"j-hui/fidget.nvim",
	event = "LspAttach",
	config = function()
		-- From existing lua/plugins/fidget.lua
		require("fidget").setup({
			notification = {
				window = {
					winblend = 0,
				},
			},
		})
	end,
}
