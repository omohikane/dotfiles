local M = {
	"vim-skk/skkeleton",
	name = "skkeleton",
	dependencies = { "vim-denops/denops.vim" },
	lazy = false,
}

function M.config()
	-- Denops起動後に設定と初期化を行う
	-- ※ 辞書や変換の有効化にはこのイベントでの設定が確実です
	vim.api.nvim_create_autocmd("User", {
		group = vim.api.nvim_create_augroup("skkeleton_init", { clear = true }),
			pattern = "skkeleton-initialize-pre",
			callback = function()
				local skk_base = vim.fn.expand("~/.config/skkeleton")
				vim.fn["skkeleton#config"]({
					globalDictionaries = {
						skk_base .. "/dicts/SKK-JISYO.L.utf8",
						skk_base .. "/dicts/SKK-JISYO.jinmei.utf8",
						skk_base .. "/dicts/SKK-JISYO.propernoun.utf8",
						skk_base .. "/dicts/SKK-JISYO.geo.utf8",
						skk_base .. "/dicts/SKK-JISYO.station.utf8",
						skk_base .. "/dicts/SKK-JISYO.itaiji.utf8",
					},
					userDictionary = skk_base .. "/SKK-JISYO.user",
					eggLikeNewline = true,
					registerConvertResult = true,
					immediatelyCancel = false,
					showCandidatesCount = 0,
					databasePath = skk_base .. "/database.db",
				})
			end,
	})

	-- キーマップの設定
	local opts = { silent = true }
	vim.keymap.set({ "i", "c" }, "<C-q>", "<Plug>(skkeleton-toggle)", opts)
	vim.keymap.set({ "i", "c" }, "<C-j>", "<Plug>(skkeleton-toggle)", opts)
end

-- Lualineなどで使用するモード表示関数
function M.mode_status()
	if vim.fn.exists("*skkeleton#mode") == 0 then
		return ""
	end
	local mode = vim.fn["skkeleton#mode"]()
	local symbols = {
		hira = "あ",
		kata = "ア",
		hankata = "ｱ",
		zenkaku = "全",
		abbrev = "a",
	}
	return symbols[mode] or ""
end

return M
