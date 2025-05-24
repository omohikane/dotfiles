-- plugins/lexima.lua

vim.g.lexima_no_default_rules = true
vim.fn["lexima#set_default_rules"]()

-- 追加ルールの例（お好みで）
vim.fn["lexima#add_rule"]({
  char = '<',
  input_after = '>',
  at = '\\%#',
  filetype = { 'html', 'xml' }
})

