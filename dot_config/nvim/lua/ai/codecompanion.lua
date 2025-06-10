-- lua/ai/codecompanion.lua

local models = {
	{
		name = "OpenAI GPT-4",
		provider = "openai",
		model = "gpt-4-turbo",
		apikey = vim.env.OPENAI_API_KEY,
	},
	{
		name = "Ollama LLaMA3",
		provider = "ollama",
		model = "llama3",
	},
	{
		name = "Perplexity",
		provider = "perplexity",
		model = "pplx-7b-online",
		apikey = vim.env.PPLX_API_KEY,
	},
	{
		name = "Gemini (Google)",
		provider = "google",
		model = "gemini-pro",
		apikey = vim.env.GEMINI_API_KEY,
	},
	{
		name = "Claude 3 Haiku",
		provider = "openrouter",
		model = "anthropic/claude-3-haiku",
		apikey = vim.env.OPENROUTER_API_KEY,
	},
	{
		name = "🌊 DeepSeek R1 0528",
		provider = "openrouter",
		model = "deepseek/deepseek-r1-0528",
		apikey = vim.env.OPENROUTER_API_KEY,
	},
	{
		name = "🌸 Gemini 2.0 Flash",
		provider = "openrouter",
		model = "google/gemini-flash-2",
		apikey = vim.env.OPENROUTER_API_KEY,
	},
	{
		name = "🔮 DeepSeek R1T Chimera",
		provider = "openrouter",
		model = "tngtech/deepseek-r1t-chimera",
		apikey = vim.env.OPENROUTER_API_KEY,
	},
	{
		name = "🧠 Devstral Small",
		provider = "openrouter",
		model = "mistralai/devstral-small-2505",
		apikey = vim.env.OPENROUTER_API_KEY,
	},
	{
		name = "🛡 MAI DS R1 (Microsoft)",
		provider = "openrouter",
		model = "microsoft/mai-ds-r1",
		apikey = vim.env.OPENROUTER_API_KEY,
	},
}

require("codecompanion").setup({
	provider = {
		provider = models[1].provider,
		model = models[1].model,
		apikey = models[1].apikey,
	},
})

local function choose_model()
	vim.ui.select(models, {
		prompt = "💡 Select AI Model:",
		format_item = function(item)
			return item.name
		end,
	}, function(choice)
		if choice then
			require("codecompanion").switch_provider({
				provider = choice.provider,
				model = choice.model,
				apikey = choice.apikey,
			})
			vim.notify("✅ Changed: " .. choice.name)
		end
	end)
end

vim.keymap.set("n", "<leader>ai", choose_model, { desc = "🧠 Choose AI Model" })
