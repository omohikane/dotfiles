local devicons = require("nvim-web-devicons")  -- ✅ Lua 側はハイフンでOK（これは実は正しいです）

devicons.setup({
  default = true,
  override = {
    fish = {
      icon = "🐟",
      color = "#428850",
      name = "Fish"
    }
  },
  strict = true,
  color_icons = true,
})

