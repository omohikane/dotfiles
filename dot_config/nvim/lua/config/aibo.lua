-- lua/config/aibo.lua
local M = {}

function M.setup()
	local ok, aibo = pcall(require, "aibo")
	if not ok then
		return
	end

	aibo.setup({
		prompt_height = 8,
		prompt_title = " [Enter]: New line | [Ctrl+Enter]: SUBMIT | [Esc]: Close ",
	})

	local map = vim.keymap.set

	-- AI Chat (Gemini)
	map("n", "<Leader>ai", function()
		local width = math.floor(vim.o.columns * 0.4)
		require("aibo.internal.console_window").toggle_or_open("gemini", nil, {
			opener = "botright " .. width .. "vsplit",
		})
	end, { desc = "Gemini Chat (Split)" })

	-- Context Actions
	map({ "n", "v" }, "<Leader>as", ":AiboSend -submit<CR>", { desc = "Submit to AI", silent = true })

	-- Session Resume
	map("n", "<Leader>ar", function()
		local width = math.floor(vim.o.columns * 0.4)
		require("aibo.internal.console_window").toggle_or_open("gemini", { "--resume", "latest" }, {
			opener = "botright " .. width .. "vsplit",
		})
	end, { desc = "Gemini Session Resume" })
end

return M
