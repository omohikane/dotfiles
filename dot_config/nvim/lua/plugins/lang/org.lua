return {
	"nvim-orgmode/orgmode",
	event = "VeryLazy",
	ft = { "org" },
	config = function()
		-- Setup orgmode
		require("orgmode").setup({
			org_agenda_files = {},
			org_default_notes_file = "", -- 基本的にスクラッチ用途なので空
		})
	end,
}
