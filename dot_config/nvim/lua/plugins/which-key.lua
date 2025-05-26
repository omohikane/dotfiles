-- lua/plugins/which-key.lua

return function()
  local ok, which_key = pcall(require, "which-key")
  if not ok then
    vim.notify("which-key.nvim が読み込めませんでした", vim.log.levels.ERROR)
    return
  end

  which_key.setup({
    plugins = {
      spelling = { enabled = true },
    },
    win = {  -- ✅ 最新仕様
      border = "single",
      position = "bottom",
    },
    layout = {
      align = "center",
    },
  })

  -- 推奨形式でキーマッピング登録
  local mappings = {
    { "<leader>f", group = "file" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
    { "<leader>b", group = "buffer" },
    { "<leader>bn", "<cmd>enew<cr>", desc = "New Buffer" },
    { "<leader>bd", "<cmd>bdelete<cr>", desc = "Delete Buffer" },
    { "<leader>g", group = "git" },
    { "<leader>gs", "<cmd>GinStatus<cr>", desc = "Git Status" },
    { "<leader>t", group = "terminal" },
    { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
  }

  for _, map in ipairs(mappings) do
    if map.group then
      which_key.register({ [map[1]] = { name = map.group } })
    else
      which_key.register({ [map[1]] = { map[2], map.desc } })
    end
  end
end

