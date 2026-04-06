return {
	"delphinus/skkeleton-indicator.nvim",
	event = "VeryLazy",
	opts = {
		-- 気にしない場合はデフォルトのままでも十分実用的です
		fadeOutMs = 3000,
		ignoreConfig = false,
		-- 表示される文字列のカスタマイズ（lualine側と合わせると統一感が出ます）
		mappings = {
		    hira = "🈔 あ",
		    kata = "🈔 ア",
		    hankata = "🈔 ｱ",
		    zenkaku = "🈔 全",
		    abbrev = "🈔 a",
		},
	},
}
