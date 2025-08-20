-- Leader mapping
vim.g.mapleader = " "
vim.g.maplocalleader = ","


-- ---------- Utilities ----------
local uv = vim.uv or vim.loop

local function fs_exists(path)
  local stat = uv.fs_stat(path)
  return stat ~= nil
end

local function join_paths(...)
  local tbl = { ... }
  return table.concat(tbl, "/")
end

-- Remove ".git" suffix at the end of the string
local function strip_git_suffix(s)
  return (s:gsub("%.git$", ""))
end

-- Clone a GitHub repo if not exists
local function ensure_repo_exists(repo_with_git, dst)
  if fs_exists(dst) then
    return
  end
  vim.fn.mkdir(dst, "p")
  local url = "https://github.com/" .. repo_with_git
  local cmd = { "git", "clone", "--depth", "1", url, dst }
  local out = vim.fn.system(cmd)
  if vim.v.shell_error ~= 0 then
    vim.notify("git clone failed: " .. url .. "\n" .. out, vim.log.levels.ERROR)
  end
end

-- ---------- Paths ----------
local data_dir  = vim.fn.stdpath("data")   -- e.g. ~/.local/share/nvim
local cache_dir = vim.fn.stdpath("cache")  -- e.g. ~/.cache/nvim
local conf_dir  = vim.fn.stdpath("config") -- e.g. ~/.config/nvim

local gh_base   = join_paths(data_dir, "dpp", "repos", "github.com")

local denopsSrc = join_paths(gh_base, "denops", "denops.vim")
local dppSrc    = join_paths(gh_base, "Shougo", "dpp.vim")

-- ---------- .env file (optional) ----------
do
  local env_path = join_paths(conf_dir, ".env")
  if vim.fn.filereadable(env_path) == 1 then
    local ok, envmod = pcall(require, "core.env")
    if ok and type(envmod) == "table" and type(envmod.load) == "function" then
      pcall(envmod.load, env_path)
    else
      -- Fallback: simple loader
      for line in io.lines(env_path) do
        local k, v = line:match("^%s*([%w_]+)%s*=%s*(.-)%s*$")
        if k and v then vim.fn.setenv(k, v) end
      end
    end
  end
end

-- ---------- Ensure core plugins ----------
ensure_repo_exists("vim-denops/denops.vim.git", denopsSrc)
ensure_repo_exists("Shougo/dpp.vim.git",        dppSrc)

-- Add dpp to Lua path
package.path  = package.path  .. ";" .. dppSrc .. "/?/init.lua;" .. dppSrc .. "/?.lua"
package.cpath = package.cpath .. ";" .. dppSrc .. "/?.so"

-- Add denops.vim first in runtimepath
vim.opt.runtimepath:prepend(denopsSrc)

-- ---------- DPP core ----------
local dpp       = require("dpp")
local dppBase   = join_paths(cache_dir, "dpp")
local dppConfig = join_paths(conf_dir, "config.ts")

-- ---------- DPP extensions ----------
do
  local extension_urls = {
    "Shougo/dpp-ext-installer.git",
    "Shougo/dpp-ext-toml.git",
    "Shougo/dpp-protocol-git.git",
    "Shougo/dpp-ext-lazy.git",
    "Shougo/dpp-ext-local.git",
  }
  for _, url in ipairs(extension_urls) do
    local dst = join_paths(gh_base, strip_git_suffix(url))
    ensure_repo_exists(url, dst)
    vim.opt.runtimepath:append(dst)
  end
end

-- ---------- Initialise DPP (only once) ----------
vim.api.nvim_create_autocmd("User", {
  pattern = "DenopsReady",
  once = true,
  callback = function()
    local ok = pcall(dpp.load_state, dppBase)
    if not ok then
      vim.notify("[dpp] state not found; running make_state()", vim.log.levels.WARN)
      dpp.make_state(dppBase, dppConfig)
    else
      vim.notify("[dpp] state loaded", vim.log.levels.INFO)
    end
  end,
})

-- ---------- User commands ----------
vim.api.nvim_create_user_command("DppInstall", function()
  local ok, err = pcall(function()
    dpp.make_state(dppBase, dppConfig)
  end)
  if not ok then
    vim.notify("[dpp] make_state failed: " .. tostring(err), vim.log.levels.ERROR)
  end
end, {})

vim.api.nvim_create_user_command("DppUpdate", function()
  local ok, installer = pcall(require, "dpp.installer")
  if ok and installer and installer.update then
    installer.update()
  else
    pcall(dpp.make_state, dppBase, dppConfig)
  end
end, {})

-- Example: safely load local modules
-- pcall(require, "plugins.local_example")

