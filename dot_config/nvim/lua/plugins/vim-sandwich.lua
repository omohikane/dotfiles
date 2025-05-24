-- plugins/vim-sandwich.lua

local loaded = vim.fn.exists("*sandwich#default_recipes#load") == 1

if loaded then
  vim.g["sandwich#recipes"] = vim.fn["sandwich#default_recipes#load"]()
else
  vim.schedule(function()
    if vim.fn.exists("*sandwich#default_recipes#load") == 1 then
      vim.g["sandwich#recipes"] = vim.fn["sandwich#default_recipes#load"]()
    else
      vim.notify("⚠ sandwich#default_recipes#load が利用できませんでした", vim.log.levels.WARN)
    end
  end)
end

