-- plugins/vim-sandwich.lua

vim.schedule(function()
	if vim.fn.exists("*sandwich#default_recipes#load") == 1 and vim.fn.exists("*sandwich#recipe#extend") == 1 then
		vim.g["sandwich#recipes"] = vim.fn["sandwich#default_recipes#load"]()
	else
		vim.notify("⚠ sandwich#default_recipes#load が利用できませんでした", vim.log.levels.WARN)
	end
end)
