-- lua/config/todo_comments.lua
local M = {}

function M.setup()
	local ok, todo = pcall(require, "todo-comments")
	if not ok then
		return
	end

	todo.setup({
		signs = true,
		sign_priority = 8,
		keywords = {
			FIX = { icon = "", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
			TODO = { icon = "", color = "info" },
			HACK = { icon = "", color = "warning" },
			WARN = { icon = "", color = "warning", alt = { "WARNING", "XXX" } },
			PERF = { icon = "", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
			NOTE = { icon = "󰎚", color = "hint", alt = { "INFO" } }, -- Changed icon to more standard Nerd Font
			TEST = { icon = "⏲", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
		},
		gui_style = {
			fg = "NONE",
			bg = "BOLD",
		},
		highlight = {
			multiline = true,
			multiline_pattern = "^.",
			multiline_context = 10,
			before = "",
			keyword = "wide",
			after = "fg",
			pattern = [[.*<(KEYWORDS)\s*:]],
			comments_only = true,
			max_line_len = 400,
			exclude = {},
		},
	})
end

return M
