-- lua/lang/init.lua
local M = {}

function M.setup()
  pcall(require, "lang.typescript").setup
  pcall(require("lang.typescript").setup)

  pcall(require("lang.python").setup)
  pcall(require("lang.lua").setup)
  pcall(require("lang.yaml").setup)
  pcall(require("lang.markdown").setup)
  pcall(require("lang.bash").setup)

  pcall(require("lang.terraform").setup)
end

return M

