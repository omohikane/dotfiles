-- lua/ai/codecompanion.lua（エクスポート版）
local M = {}

function M.setup()
	local ok, cc = pcall(require, "codecompanion")
	if not ok then
		vim.defer_fn(function()
			local ok2, cc2 = pcall(require, "codecompanion")
			if ok2 then
				pcall(cc2.setup, {})
			end
		end, 800)
		return
	end

	local OLLAMA_HOST = vim.env.OLLAMA_HOST or "http://127.0.0.1:11434"
	local OLLAMA_MODEL = vim.env.OLLAMA_MODEL or "codellama:7b"

	cc.setup({
		adapters = {
			http = {
				openai_ollama = {
					type = "openai",
					endpoint = OLLAMA_HOST .. "/v1",
					api_key = "ollama",
					model = OLLAMA_MODEL,
				},
				opts = { timeout = 30000 },
			},
		},
		strategies = {
			chat = { adapter = "openai_ollama", model = OLLAMA_MODEL, opts = {} },
			inline = { adapter = "openai_ollama", model = OLLAMA_MODEL, opts = {} }, -- ★ nil回避
			cmd = { adapter = "openai_ollama", model = OLLAMA_MODEL, opts = {} },
		},
	})

	-- ---- safety wrapper: inline/chat always get opts ----
	do
		local ok2, CC = pcall(require, "codecompanion")
		if ok2 and type(CC.inline) == "function" and type(CC.chat) == "function" then
			local _inline = CC.inline
			CC.inline = function(cfg)
				cfg = cfg or {}
				cfg.opts = cfg.opts or {} -- ★ ここで必ず用意
				return _inline(cfg)
			end
			local _chat = CC.chat
			CC.chat = function(cfg)
				cfg = cfg or {}
				cfg.opts = cfg.opts or {} -- 念のため chat 側も
				return _chat(cfg)
			end
		end
	end

	local function bind(adapter, model)
		-- VISUAL: インライン
		vim.keymap.set("v", "<leader>ai", function()
			require("codecompanion").inline({
				adapter = "openai_ollama",
				model = "codellama:7b",
				opts = {}, -- ★ 念のため明示
			})
		end, { desc = "AI Inline (Ollama codellama:7b)" })

		-- NORMAL: チャット
		vim.keymap.set("n", "<leader>ac", function()
			require("codecompanion").chat({
				adapter = "openai_ollama",
				model = "codellama:7b",
				opts = {}, -- ★ 念のため明示
			})
		end, { desc = "AI Chat (Ollama codellama:7b)" })
	end

	bind("openai_ollama", OLLAMA_MODEL)

	vim.keymap.set("n", "<leader>aM", function()
		local items = {
			{ label = "Ollama / CodeLlama 7B", adapter = "openai_ollama", model = "codellama:7b" },
			{ label = "Ollama / CodeLlama 7B Instruct", adapter = "openai_ollama", model = "codellama:7b-instruct" },
			{ label = "Ollama / llama3.1:8b", adapter = "openai_ollama", model = "llama3.1:8b" },
		}
		vim.ui.select(items, {
			prompt = "💡 Select AI Model:",
			format_item = function(i)
				return i.label
			end,
		}, function(choice)
			if choice then
				bind(choice.adapter, choice.model)
			end
		end)
	end, { desc = "AI: Choose backend/model" })
end

return M
