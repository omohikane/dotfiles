return {
	"folke/sidekick.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
	cmd = { "Sidekick", "SidekickChat", "SidekickInline", "SidekickPrompt" },
	config = function()
		-- From existing lua/plugins/sidekick.lua
		require("sidekick").setup({
			provider = "gemini",
			api_key_cmd = "cat ~/.gemini_api_key",
		})
	end,
}
