-- lua/core/dashboard.lua

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

local session_path = vim.fn.stdpath("cache") .. "/session.vim"

dashboard.section.header.val = {
  "  ❖ ごきげんよう、琥珀でございます ❖",
  "   本日も素敵なひとときをお過ごしくださいませ",
}

dashboard.section.buttons.val = {
  dashboard.button("e", "📄  新規ファイル", ":ene <BAR> startinsert<CR>"),
  dashboard.button("f", "🔍  ファイルを探す", ":Telescope find_files<CR>"),
  dashboard.button("r", "🕰  最近使ったファイル", ":Telescope oldfiles<CR>"),
  dashboard.button("s", "💾  セッション復元", ":source " .. session_path .. "<CR>"),
  dashboard.button("q", "💤  終了します", ":qa<CR>"),
}

dashboard.section.footer.val = "🌸 琥珀はいつでもそばに"

local M = {}

function M.setup()
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      -- ファイル引数がないときのみ表示
      if vim.fn.argc() == 0 then
        alpha.setup(dashboard.opts)
        vim.cmd("Alpha")
      end
    end
  })
end

return M

