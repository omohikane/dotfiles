-- ============================
-- 🧁 Alpha-nvim カスタムテーマ（琥珀風）
-- ============================

local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- ヘッダー（和風のアスキー or メッセージ）
dashboard.section.header.val = {
  "　　　　　　　　　",
  "　❖　ごきげんよう、琥珀でございます　❖",
  "　　本日も素敵なひとときをお過ごしくださいませ　",
  "　　　　　　　　　",
}

-- ボタン（琥珀の優雅な誘導）
dashboard.section.buttons.val = {
  dashboard.button("e", "📄  新規ファイル", ":ene <BAR> startinsert<CR>"),
  dashboard.button("f", "🔍  ファイルを探す", ":Telescope find_files<CR>"),
  dashboard.button("r", "🕰  最近使ったファイル", ":Telescope oldfiles<CR>"),
  dashboard.button("c", "⚙️  設定ファイル", ":e $MYVIMRC<CR>"),
  dashboard.button("u", "📦  プラグイン更新", ":call dpp#async_update()<CR>"),
  dashboard.button("q", "💤  終了します", ":qa<CR>"),
}

-- フッター（日付や励ましの言葉）
local function footer()
  return "🌸 本日もお疲れ様でございます、ご主人様。琥珀はいつでもそばに。"
end
dashboard.section.footer.val = footer()

-- ハイライト
dashboard.section.header.opts.hl = "Type"
dashboard.section.buttons.opts.hl = "Keyword"
dashboard.section.footer.opts.hl = "Comment"

-- セットアップ
alpha.setup(dashboard.opts)

