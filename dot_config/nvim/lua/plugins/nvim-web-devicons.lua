-- lua/plugins/nvim-web-devicons.lua

return function()
  local ok, devicons = pcall(require, "nvim-web-devicons")

  if ok then
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
  else
    vim.schedule(function()
      local fallback_ok, fallback_devicons = pcall(require, "nvim-web-devicons")
      if fallback_ok then
        fallback_devicons.setup({
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
      else
        vim.notify("⚠ nvim-web-devicons could not be loaded", vim.log.levels.WARN)
      end
    end)
  end
end

