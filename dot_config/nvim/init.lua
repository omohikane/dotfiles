-- ~/.config/nvim/init.lua

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- env 
pcall(function() require("core.env").load(vim.fn.stdpath("config") .. "/.env") end)

-- Paths
local cache_path = vim.fs.joinpath(vim.fn.stdpath("cache"), "dpp", "repos", "github.com")
local dppSrc     = vim.fs.joinpath(cache_path, "Shougo", "dpp.vim")
local denopsSrc  = vim.fs.joinpath(cache_path, "vim-denops", "denops.vim")
local dppBase    = vim.fn.stdpath("cache") .. "/dpp"
local dppConfig  = vim.fn.stdpath("config") .. "/config.ts"   

-- rtp for Lua require
local dpp_path = vim.fn.stdpath("cache") .. "/dpp/repos/github.com"
package.path  = package.path .. ";" .. dpp_path .. "/?/init.lua;" .. dpp_path .. "/?.lua"
package.cpath = package.cpath .. ";" .. dpp_path .. "/?.so"

-- clone helper
local function ensure_repo(repo)
  local dest = vim.fs.joinpath(cache_path, repo)
  if vim.loop.fs_stat(dest) then return dest end
  local url = "https://github.com/" .. repo .. ".git"
  local ok = vim.fn.system({ "git", "clone", "--depth=1", url, dest })
  if vim.v.shell_error ~= 0 then
    vim.notify("clone failed: " .. url, vim.log.levels.WARN)
  end
  return dest
end

vim.opt.runtimepath:prepend(ensure_repo("Shougo/dpp.vim"))
vim.opt.runtimepath:prepend(ensure_repo("vim-denops/denops.vim"))

local exts = {
  "Shougo/dpp-ext-installer",
  "Shougo/dpp-ext-toml",
  "Shougo/dpp-protocol-git",
  "Shougo/dpp-ext-lazy",
}
for _, r in ipairs(exts) do vim.opt.runtimepath:append(ensure_repo(r)) end

local ok, dpp = pcall(require, "dpp")
if not ok then
  vim.notify("dpp not found", vim.log.levels.ERROR)
else
  if not pcall(dpp.load_state, dppBase) then
    pcall(dpp.make_state, dppBase, dppConfig)
  end

  vim.api.nvim_create_autocmd("User", {
    pattern = "DenopsReady",
    once = true,  
    callback = function()
      pcall(dpp.make_state, dppBase, dppConfig)
    end,
  })
end

vim.cmd("filetype indent plugin on")
vim.cmd("syntax on")
pcall(require, "core.options")
pcall(require, "core.keymaps")
pcall(require, "core.autocmds")
pcall(require, "core.diagnostics")
pcall(require, "lsp")

-- ===== dpp auto-bootstrap (install if needed) =====
local dpp_ok, dpp = pcall(require, "dpp")
if dpp_ok then
  local dppBase    = vim.fn.stdpath("cache") .. "/dpp"
  local repos_root = dppBase .. "/repos/github.com"
  local state_dir  = vim.fn.stdpath("state") .. "/dpp"
  vim.fn.mkdir(state_dir, "p")
  local marker     = state_dir .. "/bootstrap_done"

  -- repos が空っぽ or マーカが無い → 初回とみなす
  local need_bootstrap = (vim.fn.glob(repos_root .. "/*/*") == "") or (vim.fn.filereadable(marker) == 0)

  -- make_state は毎起動で idempotent（安全）
  pcall(dpp.make_state, dppBase, vim.fn.stdpath("config") .. "/config.ts")

  local function run_install()
    pcall(dpp.async_ext_action, "installer", "install")
    pcall(dpp.load_state, dppBase)
    vim.fn.writefile({ os.date() .. " bootstrap ok" }, marker)
  end

  if need_bootstrap then
    vim.api.nvim_create_autocmd("User", {
      pattern = "DenopsReady",
      once = true,
      callback = run_install,
    })
  else
    vim.api.nvim_create_autocmd("User", {
      pattern = "DenopsReady",
      once = true,
      callback = function()
        pcall(dpp.async_ext_action, "installer", "install")
      end,
    })
  end
end


-- === dpp helper user-commands ===
local dppBase   = vim.fn.stdpath("cache") .. "/dpp"
local dppConfig = vim.fn.stdpath("config") .. "/config.ts"

vim.api.nvim_create_user_command("DppMakeState", function()
  local ok, dpp = pcall(require, "dpp")
  if ok then pcall(dpp.make_state, dppBase, dppConfig) else vim.notify("dpp not found", vim.log.levels.ERROR) end
end, {})

vim.api.nvim_create_user_command("DppInstall", function()
  local ok, dpp = pcall(require, "dpp")
  if ok then pcall(dpp.async_ext_action, "installer", "install") end
end, {})

vim.api.nvim_create_user_command("DppUpdate", function(opts)
  local ok, dpp = pcall(require, "dpp")
  if ok then pcall(dpp.async_ext_action, "installer", "update", { names = opts.fargs }) end
end, { nargs = "*" })


