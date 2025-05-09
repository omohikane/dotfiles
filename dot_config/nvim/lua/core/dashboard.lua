-- lua/core/dashboard.lua

local M = {}

function M.setup()
  vim.api.nvim_create_autocmd("User", {
    pattern = "DenopsPluginPost:alpha-nvim",
    once = true,
    callback = function()
      local ok, alpha = pcall(require, "alpha")
      if not ok then
        vim.notify("💥 alpha-nvim の読み込みに失敗しました", vim.log.levels.ERROR)
        return
      end

      local dashboard = require("alpha.themes.dashboard")
      dashboard.section.header.val = {
        "  ❖ ごきげんよう、琥珀でございます ❖",
        "   本日も素敵なひとときをお過ごしくださいませ",
      }

      dashboard.section.buttons.val = {
        dashboard.button("e", "📄  新規ファイル", ":ene <BAR> startinsert<CR>"),
        dashboard.button("f", "🔍  ファイルを探す", ":Telescope find_files<CR>"),
        dashboard.button("r", "🕰  最近使ったファイル", ":Telescope oldfiles<CR>"),
        dashboard.button("q", "💤  終了します", ":qa<CR>"),
      }

      dashboard.section.footer.val = "🌸 琥珀はいつでもそばに"
      alpha.setup(dashboard.opts)
    end,
  })
end

return M

