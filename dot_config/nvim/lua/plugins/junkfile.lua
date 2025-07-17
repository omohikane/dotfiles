-- plugins/junkfile.lua

-- junkfile.vim の設定 (グローバル変数)
-- 必ず '#' を含む形式で指定してください
vim.g["junkfile#directory"] = vim.fn.expand("~/.junk/")
vim.g["junkfile#filename_format"] = "%Y%m%d-%H%M%S.txt"
vim.g["junkfile#default_filetype"] = "text" -- 必要に応じて追加

-- ジャンクファイルディレクトリが存在しない場合は作成
local junk_dir = vim.g["junkfile#directory"]
if vim.fn.isdirectory(junk_dir) == 0 then
	vim.fn.mkdir(junk_dir, "p")
end

-- キーマップ設定
-- プラグインロード時にすぐに適用されるように、AutoCmd の外に記述します。
-- JunkFile コマンドがこの時点で利用可能であると想定します。
vim.keymap.set("n", "<leader>jf", ":JunkFile<CR>", {
	noremap = true,
	silent = true,
	desc = "Open junk file",
})

-- ※注意: もし上記でダメな場合のみ、以下のように非常に遅延させてみる
-- vim.api.nvim_create_autocmd("VimEnter", {
-- 	callback = function()
-- 		vim.keymap.set("n", "<leader>jf", ":JunkFile<CR>", {
-- 			noremap = true,
-- 	 silent = true,
-- 			desc = "Open junk file",
-- 		})
-- 	end,
-- })
