return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	config = function()
		require("noice").setup({
			lsp = {
				-- 履歴を表示するための LSP のホバーなどを有効化
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.styled_pa_lines"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
			-- 入力欄（cmdline）は画面下部に固定（認知阻害を避ける）
			cmdline = {
				view = "cmdline", -- デフォルトの最下部を使用
			},
			-- メッセージのポップアップ表示設定
			messages = {
				enabled = true,
				view = "mini", -- 控えめな通知（右下など）
				view_error = "notify",
				view_warn = "notify",
				view_history = "messages",
				view_search = "virtualtext",
			},
			-- プリセット設定
			presets = {
				bottom_search = true, -- 検索バーを下に配置
				command_palette = false, -- パレット形式ではなく従来形式
				long_message_to_split = true, -- 長いメッセージは分割表示
				inc_rename = false, -- インクリメンタルリネームはオフ（必要なら別途）
				lsp_doc_border = false, -- 枠線は控えめに
			},
		})
	end,
}
