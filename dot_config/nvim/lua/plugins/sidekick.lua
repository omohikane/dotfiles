-- lua/plugins/sidekick.lua
local M = {}

function M.setup()
	local ok, sk = pcall(require, "sidekick")
	if not ok then
		return
	end

	sk.setup({
		nes = { enabled = false },

		cli = {
			prompt_dir = vim.fn.expand("~/.config/gemini/prompts"),
			tools = {
				gemini = {
					cmd = { "gemini" },
					args = { "chat", "--model", (vim.env.GEMINI_MODEL or "gemini-2.5-pro") },
					template = [[
{prompt}

# Context
{this}
]],
					win = { border = "rounded" },
				},
				ollama = {
					cmd = { "ollama" },
					args = { "run", (vim.env.OLLAMA_MODEL or "codellama:7b") },
					template = "{prompt}\n\n{this}",
					win = { border = "rounded" },
				},
			},
		},
	})

	---------------------------------------------------------------------------
	-- 便利キーマップ
	---------------------------------------------------------------------------
	local map = vim.keymap.set
	-- CLIの開閉切り替え（Gemini を既定にする）
	map({ "n", "t", "i", "x" }, "<C-.>", function()
		require("sidekick.cli").toggle({ name = "gemini" })
	end, { desc = "Sidekick: Toggle Gemini CLI" })

	-- CLIツールの選択（gemini/ollama など）
	map("n", "<leader>as", function()
		require("sidekick.cli").select()
	end, { desc = "Sidekick: Select CLI Tool" })

	-- その場のバッファ内容を投げる
	map({ "n", "x" }, "<leader>at", function()
		require("sidekick.cli").send({ msg = " {this}" })
	end, { desc = "Sidekick: Send This" })

	-- ファイル全体を投げる
	map("n", "<leader>af", function()
		require("sidekick.cli").send({ msg = " {file}" })
	end, { desc = "Sidekick: Send File" })

	-- 選択範囲を投げる
	map("x", "<leader>av", function()
		require("sidekick.cli").send({ msg = " {selection}" })
	end, { desc = "Sidekick: Send Visual Selection" })

	-- 外部プロンプト（~/.config/gemini/prompts）を選んで実行
	map({ "n", "x" }, "<leader>ap", function()
		require("sidekick.cli").prompt({ name = "gemini" })
	end, { desc = "Sidekick: Select External Prompt" })
end

return M
