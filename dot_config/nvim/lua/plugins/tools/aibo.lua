return {
	"lambdalisue/nvim-aibo",
	config = function()
		require("aibo").setup({
			-- プロンプト（入力欄）の高さ調整
			prompt_height = 8,
			-- ショートカットキーのガイドを表示
			prompt_title = " [Enter]: New line | [Ctrl+Enter]: SUBMIT | [Esc]: Close ",
		})

		local map = vim.keymap.set

		-- ==========================
		-- 🤖 AI Chat (Gemini)
		-- ==========================
		-- 画面右側に40%の幅でチャットを開く
		map("n", "<Leader>ai", function()
			local width = math.floor(vim.o.columns * 0.4)
			require("aibo.internal.console_window").toggle_or_open("gemini", nil, {
				opener = "botright " .. width .. "vsplit",
			})
		end, { desc = "Gemini Chat (Split)" })

		-- ==========================
		-- 📝 Context Actions
		-- ==========================
		-- 選択範囲やバッファ全体をAIに送る (普通のバッファで書いてから送るのに最適)
		map({ "n", "v" }, "<Leader>as", ":AiboSend -submit<CR>", { desc = "現在の内容をAIに送信", silent = true })

		-- セッションの再開
		map("n", "<Leader>ar", function()
			local width = math.floor(vim.o.columns * 0.4)
			require("aibo.internal.console_window").toggle_or_open("gemini", { "--resume", "latest" }, {
				opener = "botright " .. width .. "vsplit",
			})
		end, { desc = "Gemini Session Resume" })

		-- Aider (必要な場合) も分割で開けるように
		map("n", "<Leader>aa", function()
			local width = math.floor(vim.o.columns * 0.4)
			require("aibo.internal.console_window").toggle_or_open("aider", nil, {
				opener = "botright " .. width .. "vsplit",
			})
		end, { desc = "Aider (Split)" })
	end,
}
