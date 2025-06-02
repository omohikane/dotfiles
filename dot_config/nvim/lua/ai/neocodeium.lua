-- lua/ai/neocodeium.lua

require("neocodeium").setup({
	enable_suggestion = true,
	enable_suggestion_on_startup = true,
	-- option で suggestion keymap 無効化したい場合：
	-- keymap = {
	--   accept_suggestion = "<C-y>",
	-- },
})
