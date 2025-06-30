-- plugins/junkfile.lua

vim.api.nvim_create_autocmd("User", {
	pattern = "DenopsReady",
	callback = function()
		vim.g.junkfile_directory = vim.fn.expand("~/.junk/")
		vim.g.junkfile_name_format = "%Y%m%d-%H%M%S.txt"

		local junk_dir = vim.g.junkfile_directory
		if vim.fn.isdirectory(junk_dir) == 0 then
			vim.fn.mkdir(junk_dir, "p")
		end

		-- shortcut
		vim.keymap.set("n", "<leader>jf", ":Junkfile<CR>", {
			noremap = true,
			silent = true,
			desc = "Open junk file",
		})
	end,
})
