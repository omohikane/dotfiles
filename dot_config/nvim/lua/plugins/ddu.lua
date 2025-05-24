-- plugins/ddu.lua

vim.fn["ddu#custom#patch_global"]({
  ui = "ff", -- フローティングなファイルファインダーUI
  sources = {
    { name = "file_rec", params = {} },
    { name = "mr" }, -- 最近のファイルなど（optional）
  },
  sourceOptions = {
    _ = {
      matchers = { "matcher_substring" },
      sorters = { "sorter_alpha" },
      converters = {},
    },
  },
  uiParams = {
    ff = {
      split = "floating",
      prompt = "> ",
      startAutoAction = true,
      autoAction = { name = "preview" },
    },
  },
})

-- ff UI を開くキー
vim.keymap.set("n", "<Leader>ff", "<Cmd>Ddu file_rec<CR>", { silent = true })
vim.keymap.set("n", "<Leader>fm", "<Cmd>Ddu mr<CR>", { silent = true })

-- カーソル位置にジャンプするプレビュー機能などを後から設定してもOK

