return {
	"lambdalisue/kensaku-command.vim",
	dependencies = { "kensaku" },
	cmd = "Kensaku",
	init = function()
		vim.keymap.set("n", "<Leader>sk", ":<C-u>Kensaku<Space>")
	end,
}
