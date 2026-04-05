return {
	"swaits/zellij-nav.nvim",
	lazy = true,
	event = "VeryLazy",
	keys = {
		{ "<A-h>", "<cmd>ZellijNavigateLeftTab<cr>", { silent = true, desc = "Navigate left or tab" } },
		{ "<A-j>", "<cmd>ZellijNavigateDown<cr>", { silent = true, desc = "Navigate down" } },
		{ "<A-k>", "<cmd>ZellijNavigateUp<cr>", { silent = true, desc = "Navigate up" } },
		{ "<A-l>", "<cmd>ZellijNavigateRightTab<cr>", { silent = true, desc = "Navigate right or tab" } },
	},
	opts = {},
}
