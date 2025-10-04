-- lua/plugins/theme.lua
vim.opt.termguicolors = true

local function load(name)
  pcall(vim.fn["dpp#ext_action"], "lazy", "load", { names = { name } })
end

local function apply(scheme)
  if scheme:match("^tokyonight%-") then
    local style = scheme:match("^tokyonight%-(.+)$")
    local ok, tn = pcall(require, "tokyonight")
    if ok and style then tn.setup({ style = style }) end
    scheme = "tokyonight"
  end
  local ok, err = pcall(vim.cmd.colorscheme, scheme)
  if not ok then vim.notify("Theme failed: "..scheme.." → "..tostring(err), vim.log.levels.WARN) end
  return ok
end

local DEFAULT = { plugin = "tokyonight", scheme = "tokyonight-moon" }
load(DEFAULT.plugin)
apply(DEFAULT.scheme)

local THEMES = {
  { plugin="tokyonight", scheme="tokyonight-moon",  label="Tokyo Night (moon)" },
  { plugin="tokyonight", scheme="tokyonight-day",   label="Tokyo Night (day)"  },
  { plugin="kanagawa",   scheme="kanagawa-wave",    label="Kanagawa (wave)"    },
  { plugin="kanagawa",   scheme="kanagawa-lotus",   label="Kanagawa (lotus)"   },
  { plugin="nightfox",   scheme="nightfox",         label="Nightfox"           },
  { plugin="nightfox",   scheme="carbonfox",        label="Carbonfox"          },
  { plugin="catppuccin", scheme="catppuccin-mocha", label="Catppuccin (mocha)" },
  { plugin="catppuccin", scheme="catppuccin-latte", label="Catppuccin (latte)" },
  { plugin="everforest", scheme="everforest",       label="Everforest"         },
  { plugin="rose-pine",   scheme="rose-pine-moon",   label="Rosé Pine (moon)"   },
  { plugin="gruvbox",    scheme="gruvbox",          label="Gruvbox"            },
}
local idx = 1
vim.api.nvim_create_user_command("ThemeNext", function()
  idx = (idx % #THEMES) + 1
  load(THEMES[idx].plugin); apply(THEMES[idx].scheme)
  vim.notify("Theme: "..THEMES[idx].label)
end, {})
vim.keymap.set("n", "<Leader>ut", "<Cmd>ThemeNext<CR>", { desc = "Theme: next" })

local function apply_highlights()
  local set = vim.api.nvim_set_hl

  local ok_inc, inc = pcall(vim.api.nvim_get_hl, 0, { name = "IncSearch", link = false })
  local ok_vis, vis = pcall(vim.api.nvim_get_hl, 0, { name = "Visual", link = false })
  if ok_inc and (inc.bg or inc.fg) then
    set(0, "MatchParen", { fg = inc.fg, bg = inc.bg, bold = true, nocombine = true })
  elseif ok_vis and vis.bg then
    set(0, "MatchParen", { bg = vis.bg, bold = true, nocombine = true })
  else
    set(0, "MatchParen", { reverse = true, bold = true, nocombine = true })
  end

  set(0, "IblIndent",     { link = "NonText" })
  set(0, "IblWhitespace", { link = "NonText" })
  set(0, "IblScope",      { bold = true })
end

local grp = vim.api.nvim_create_augroup("OjouTheme", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", { group = grp, callback = apply_highlights })
apply_highlights()

