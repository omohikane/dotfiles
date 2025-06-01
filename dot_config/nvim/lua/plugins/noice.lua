local ok, noice = pcall(require, "noice")
if not ok then
	vim.notify("Noice not loaded", vim.log.levels.WARN)
	return
end

noice.setup({
	cmdline = {
		enabled = false, -- popup を明示的に切る
	},
	messages = {
		enabled = false,
	},
	popupmenu = {
		enabled = false,
	},
	lsp = {
		progress = {
			enabled = false,
		},
		override = {},
	},
	views = {}, -- 空の views を指定して、何も描画させない
	presets = {}, -- プリセットも完全無効
})
