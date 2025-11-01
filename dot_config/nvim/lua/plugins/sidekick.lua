-- lua/plugins/sidekick.lua
local M = {}

function M.setup()
	local ok, sk = pcall(require, "sidekick")
	if not ok then
		return
	end

	local prompts = require("ai.prompts").load_all()

	sk.setup({
		cli = {
			default = "gemini",
			tools = {
				gemini = {
					cmd = "gemini",
					args = { "chat", "--model", (os.getenv("GEMINI_DEFAULT_MODEL") or "gemini-2.5-pro") },
				},
			},
		},
		ui = { border = "rounded" },
		prompts = prompts,
	})

	vim.keymap.set("n", "<leader>aa", function()
		sk.chat()
	end, { desc = "Sidekick: Chat (Gemini)" })
	-- ビジュアル選択 → 外部の "explain" を使う例
	vim.keymap.set("v", "<leader>ae", function()
		sk.actions.prompt("explain")
	end, { desc = "Sidekick: Explain" })
	vim.keymap.set("v", "<leader>ar", function()
		sk.actions.prompt("review")
	end, { desc = "Sidekick: Review" })

	-- auto-reload
	vim.api.nvim_create_user_command("SidekickReloadPrompts", function()
		local new_prompts = require("ai.prompts").load_all()
		local ok2, sk2 = pcall(require, "sidekick")
		if ok2 and type(sk2.setup) == "function" then
			sk2.setup({ prompts = new_prompts })
			vim.notify("[sidekick] prompts reloaded", vim.log.levels.INFO)
		end
	end, {})

	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = vim.fn.expand("~/.config/gemini/prompts") .. "/*.md",
		callback = function()
			pcall(vim.cmd, "SidekickReloadPrompts")
		end,
	})
end

return M
