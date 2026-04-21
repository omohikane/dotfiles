-- Leader mapping
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.g.lspconfig_silent = 1

-- load env
local env_ok, env = pcall(require, "core.env")
if env_ok then
	env.load(vim.fn.stdpath("config") .. "/.env")
end

-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim with our new consolidated spec
require("lazy").setup({
	spec = require("plugin-list"),
	install = { colorscheme = { "tokyonight" } },
	checker = { enabled = false },
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

-- Load Core Settings (Vim settings independent of plugins)
require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.diagnostics")

-- Set colorscheme
vim.cmd("colorscheme tokyonight")


-- Custom commands
vim.api.nvim_create_user_command("WriteMessages", function()
	vim.cmd("redir > ~/messages.log")
	vim.cmd("silent messages")
	vim.cmd("redir END")
	print("Messages written to ~/messages.log")
end, {})
