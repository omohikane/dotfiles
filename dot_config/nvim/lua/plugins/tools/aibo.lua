return {
	"lambdalisue/nvim-aibo",
	config = function()
		require("aibo").setup()

		-- AI アシスタントウィンドウを起動/切り替え
		vim.keymap.set("n", "<leader>ai", "<cmd>Aibo<CR>", { desc = "AI アシスタント (Aibo) を起動" })

		-- 特定のツールを直接呼び出すコマンド例:
		-- :Aibo ollama run llama3 (Local LLM)
		-- :Aibo gemini chat (gemini-cli がインストールされている場合)
		-- :Aibo claude (Claude Code)

		-- ※ aider について:
		-- aider は TUI のUIが複雑なため、nvim-aibo (Float窓) ではなく
		-- 先ほど設定した Zellij の別ペインで動かすのが最適（autoreadで自動反映）です。
	end,
}
