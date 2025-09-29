-- ~/.config/nvim/init.lua

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- env
pcall(function() require("core.env").load(vim.fn.stdpath("config") .. "/.env") end)

-- ---------- dpp/denops bootstrap ----------
local cache_path = vim.fs.joinpath(vim.fn.stdpath("cache"), "dpp", "repos", "github.com")
local function ensure_repo(repo)
  local dest = vim.fs.joinpath(cache_path, repo)
  if vim.loop.fs_stat(dest) then return dest end
  local url = "https://github.com/" .. repo .. ".git"
  vim.fn.system({ "git", "clone", "--depth=1", url, dest })
  if vim.v.shell_error ~= 0 then
    vim.notify("clone failed: " .. url, vim.log.levels.WARN)
  end
  return dest
end

vim.opt.runtimepath:prepend(ensure_repo("Shougo/dpp.vim"))
vim.opt.runtimepath:prepend(ensure_repo("vim-denops/denops.vim"))
for _, r in ipairs({
  "Shougo/dpp-ext-installer",
  "Shougo/dpp-ext-toml",
  "Shougo/dpp-protocol-git",
  "Shougo/dpp-ext-lazy",
}) do
  vim.opt.runtimepath:append(ensure_repo(r))
end

-- Lua package paths
local dpp_path = vim.fn.stdpath("cache") .. "/dpp/repos/github.com"
package.path  = package.path .. ";" .. dpp_path .. "/?/init.lua;" .. dpp_path .. "/?.lua"
package.cpath = package.cpath .. ";" .. dpp_path .. "/?.so"

-- ===== Quiet auto-bootstrap for dpp (cache-aware & plugin check) =====
do
  local ok, dpp = pcall(require, "dpp")
  if not ok then return end
  if vim.g.__dpp_bootstrap_ran then return end
  vim.g.__dpp_bootstrap_ran = true

  local dppBase    = vim.fn.stdpath("cache") .. "/dpp"
  local repos_root = dppBase .. "/repos/github.com"
  local marker     = dppBase .. "/.bootstrap_done"           
  local toml_path  = vim.fn.stdpath("config") .. "/toml/dein.toml"
  local config_ts  = vim.fn.stdpath("config") .. "/config.ts"

  pcall(dpp.make_state, dppBase, config_ts)

  local function plugin_missing()
    local f = io.open(toml_path, "r"); if not f then return false end
    local s = f:read("*a"); f:close()
    local missing = false
    for repo in s:gmatch('repo%s*=%s*"%s*([^"%s]+)%s*"') do
      local p = repos_root .. "/" .. repo
      if not vim.loop.fs_stat(p) then
        missing = true
        break
      end
    end
    return missing
  end

  local function need_install()
    if not vim.loop.fs_stat(marker) then return true end
    local t, m = vim.loop.fs_stat(toml_path), vim.loop.fs_stat(marker)
    if t and m and t.mtime and m.mtime and (t.mtime.sec > m.mtime.sec) then
      return true
    end
    if plugin_missing() then return true end
    return false
  end

  if need_install() then
    vim.api.nvim_create_autocmd("User", {
      pattern = "DenopsReady",
      once = true,
      callback = function()
        pcall(dpp.async_ext_action, "installer", "install") 
        pcall(dpp.load_state, dppBase)                       
        vim.fn.writefile({ os.date() .. " bootstrap ok" }, marker)
      end,
    })
  end
end


vim.cmd("filetype indent plugin on")
vim.cmd("syntax on")
pcall(require, "core.options")
pcall(require, "core.keymaps")
pcall(require, "core.autocmds")
pcall(require, "core.diagnostics")
pcall(require, "lsp")  

-- ---------- dpp helper commands ----------
do
  local dppBase   = vim.fn.stdpath("cache") .. "/dpp"
  local dppConfig = vim.fn.stdpath("config") .. "/config.ts"

  vim.api.nvim_create_user_command("DppMakeState", function()
    local ok, dpp = pcall(require, "dpp"); if not ok then return end
    pcall(dpp.make_state, dppBase, dppConfig)
  end, {})

  vim.api.nvim_create_user_command("DppInstall", function()
    local ok, dpp = pcall(require, "dpp"); if not ok then return end
    pcall(dpp.async_ext_action, "installer", "install")
  end, {})

  vim.api.nvim_create_user_command("DppUpdate", function(opts)
    local ok, dpp = pcall(require, "dpp"); if not ok then return end
    pcall(dpp.async_ext_action, "installer", "update", { names = opts.fargs })
  end, { nargs = "*" })
end

