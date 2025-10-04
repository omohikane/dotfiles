local M = {}
function M.setup()
  vim.g.rainbow_delimiters = {
    highlight = {
      "RainbowDelimiterRed","RainbowDelimiterYellow","RainbowDelimiterBlue",
      "RainbowDelimiterOrange","RainbowDelimiterGreen","RainbowDelimiterViolet",
      "RainbowDelimiterCyan",
    },
  }
end
return M

