-- Leader mapping
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- キャッシュディレクトリのパス設定
local cache_path = vim.fs.joinpath(vim.fn.stdpath("cache"), "dpp", "repos", "github.com")
local dppSrc = vim.fs.joinpath(cache_path, "Shougo", "dpp.vim")
local denopsSrc = vim.fs.joinpath(cache_path, "vim-denops", "denops.vim")
local dpp_path = vim.fn.stdpath("cache") .. "/dpp/repos/github.com"
package.path = package.path .. ";" .. dpp_path .. "/?/init.lua;" .. dpp_path .. "/?.lua"
package.cpath = package.cpath .. ";" .. dpp_path .. "/?.so"
-- read env-file
require("core.env").load(vim.fn.stdpath("config") .. "/.env")

-- SSH
if vim.env.NVIM_SSH_MODE == "1" then
	vim.g["denops#disable_healthcheck"] = 1
	vim.g["denops#server#start"] = 0

	vim.cmd([[
    function! denops#_internal#rpc#nvim#healthcheck(...) abort
    endfunction
  ]])
end

-- dpp.vim を runtimepath に追加
vim.opt.runtimepath:prepend(dppSrc)

-- 必要なリポジトリがなければ `git clone`
local function ensure_repo_exists(repo_url, dest_path)
	if vim.loop.fs_stat(dest_path) then
		-- 既に存在する場合はスキップ（起動を高速化）
		return
	end

	-- `git clone` を実行
	local cmd = { "git", "clone", "https://github.com/" .. repo_url, dest_path }
	local result = vim.fn.system(cmd)

	if vim.v.shell_error ~= 0 then
		vim.notify("Failed to clone " .. repo_url .. ": " .. result, vim.log.levels.ERROR)
	else
		vim.notify("Successfully cloned " .. repo_url, vim.log.levels.INFO)
	end
end

-- 必須プラグインのインストール（必要なときのみ）
ensure_repo_exists("vim-denops/denops.vim.git", denopsSrc)
ensure_repo_exists("Shougo/dpp.vim.git", dppSrc)

-- dpp をロード
local dpp = require("dpp")
local dppBase = vim.fn.stdpath("cache") .. "/dpp"
local dppConfig = vim.fn.stdpath("config") .. "/config.ts"

-- dpp の拡張機能を管理
local extension_urls = {
	"Shougo/dpp-ext-installer.git",
	"Shougo/dpp-ext-toml.git",
	"Shougo/dpp-protocol-git.git",
	"Shougo/dpp-ext-lazy.git",
	"Shougo/dpp-ext-local.git",
}

-- dpp の拡張機能をインストール（必要なときのみ）
for _, url in ipairs(extension_urls) do
	local ext_path = vim.fs.joinpath(cache_path, string.gsub(url, ".git", ""))
	ensure_repo_exists(url, ext_path)
	vim.opt.runtimepath:append(ext_path)
end

-- dpp のロード状態を確認し、必要なら make_state を実行
if not pcall(dpp.load_state, dppBase) then
	vim.notify("Failed to load dpp state, running make_state()", vim.log.levels.WARN)
	dpp.make_state(dppBase, dppConfig)
else
	vim.notify("Successfully loaded dpp state", vim.log.levels.INFO)
end

-- denops.vim を runtimepath に追加
vim.opt.runtimepath:prepend(denopsSrc)

-- Denops が準備できたら dpp.make_state() を実行
vim.api.nvim_create_autocmd("User", {
	pattern = "DenopsReady",
	callback = function()
		vim.notify("Denops is ready, executing dpp.make_state()", vim.log.levels.INFO)
		dpp.make_state(dppBase, dppConfig)
	end,
})

-- 基本的な設定
vim.cmd("filetype indent plugin on")
vim.cmd("syntax on")

-- Neovim の基本設定を読み込む
require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.diagnostics")
require("lsp")

-- プラグイン設定をロード
local function load_plugin_configs()
	local plugins_path = vim.fn.stdpath("config") .. "/lua/plugins"
	for _, file in ipairs(vim.fn.readdir(plugins_path)) do
		if file:match("%.lua$") then
			local module_name = "plugins." .. file:gsub("%.lua$", "")
			require(module_name)
		end
	end
end

-- `DppInstall` コマンド
vim.api.nvim_create_user_command("DppInstall", function()
	dpp.async_ext_action("installer", "install")
	vim.notify("DppInstall executed!", vim.log.levels.INFO)
end, {})

-- `DppUpdate` コマンド
vim.api.nvim_create_user_command("DppUpdate", function(opts)
	local plugins = (#opts.fargs == 0) and "all plugins" or table.concat(opts.fargs, ", ")
	dpp.async_ext_action("installer", "update", { names = opts.fargs })
	vim.notify("Updated: " .. plugins, vim.log.levels.INFO)
end, { nargs = "*" })

-- 'SaveMessages'
vim.api.nvim_create_user_command("WriteMessages", function()
	vim.cmd("redir > ~/messages.log")
	vim.cmd("silent messages")
	vim.cmd("redir END")
	print("Messages written to ~/messages.log")
end, {})
