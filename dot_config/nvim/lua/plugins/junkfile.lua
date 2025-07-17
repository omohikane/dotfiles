-- plugins/junkfile.lua

-- junkfile.vim がロードされた直後でも設定が反映されるように、AutoCmdの外に設定を移動
-- ただし、DenopsReadyに依存する設定（例: Denops系のプラグインとの連携）はAutoCmd内でも良い
-- junkfile.vim の設定は基本的に即時反映されるべきです

-- グローバル変数のキー名に '#' を含めます
vim.g["junkfile#directory"] = vim.fn.expand("~/.junk/")
vim.g["junkfile#filename_format"] = "%Y%m%d-%H%M%S.txt"
vim.g["junkfile#default_filetype"] = "text" -- オプションでデフォルトファイルタイプも設定

local junk_dir = vim.g["junkfile#directory"] -- 正しいキー名で取得
if vim.fn.isdirectory(junk_dir) == 0 then
	vim.fn.mkdir(junk_dir, "p")
end

-- キーマップは、Neovim起動時に設定されるべきなのでAutoCmdの外でも良いが、
-- 確実性を期すため、プラグインロード後すぐに設定されるようにします。
-- もし DenopsReady イベントが、JunkFile コマンドが定義されるより「後」に発火するなら、
-- この AutoCmd の中に書くことは正しい選択です。
vim.api.nvim_create_autocmd("User", {
	pattern = "DenopsReady",
	callback = function()
		-- shortcut
		vim.keymap.set("n", "<leader>jf", ":Junkfile<CR>", {
			noremap = true,
			silent = true,
			desc = "Open junk file",
		})
	end,
})

-- あるいは、DenopsReadyに依存しないシンプルなキーマップであれば
-- AutoCmdの外に記述しても構いません。
-- vim.keymap.set("n", "<leader>jf", ":Junkfile<CR>", {
-- 	noremap = true,
-- 	silent = true,
-- 	desc = "Open junk file",
-- })
