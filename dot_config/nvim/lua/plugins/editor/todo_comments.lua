return {
	"folke/todo-comments.nvim",
	event = "VeryLazy",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		-- 控えめなアイコン設定
		signs = true,
		sign_priority = 8,
		keywords = {
			FIX = { icon = "", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
			TODO = { icon = "", color = "info" },
			HACK = { icon = "", color = "warning" },
			WARN = { icon = "", color = "warning", alt = { "WARNING", "XXX" } },
			PERF = { icon = "", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
			NOTE = { icon = "", color = "hint", alt = { "INFO" } },
			TEST = { icon = "⏲", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
		},
		gui_style = {
			fg = "NONE", -- 背景色を目立たせる場合は "BOLD"
			bg = "BOLD",
		},
		merge_keywords = true,
		highlight = {
			multiline = true,
			multiline_pattern = "^.",
			multiline_context = 10,
			before = "", -- 内容だけでなく前後のハイライトも可能
			keyword = "wide", -- "bg", "fg", "wide", "empty"
			after = "fg",
			pattern = [[.*<(KEYWORDS)\s*:]],
			comments_only = true,
			max_line_len = 400,
			exclude = {},
		},
	},
}
