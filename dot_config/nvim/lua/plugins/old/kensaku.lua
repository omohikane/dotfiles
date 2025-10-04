-- plugins/kensaku.lua

return {
	"lambdalisue/kensaku.vim",
	dependencies = {
		"lambdalisue/kensaku-search.vim",
	},
	config = function()
		vim.cmd([[
      cnoremap <expr> <CR> getcmdtype() == '/' ? "<Cmd>kensaku-search<CR>" : "<CR>"
    ]])
	end,
}
