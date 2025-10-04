-- lua/plugins/neotree.lua
vim.g.neo_tree_remove_legacy_commands = 1

local ok, neotree = pcall(require, "neo-tree")
if not ok then
  return
end

neotree.setup({
  close_if_last_window = true,
  popup_border_style = "rounded",
  sources = { "filesystem", "buffers", "git_status", "diagnostics" },
  source_selector = { winbar = true },  -- タブ状の切替（上部に）
  window = {
    position = "left",
    width = 34,
    mappings = {
      ["s"] = "open_vsplit",  -- 右に分割
      ["S"] = "open_split",   -- 下に分割
      ["t"] = "open_tabnew",  -- 新しいタブ
      ["R"] = "refresh",      -- 再読込
      ["H"] = "toggle_hidden" -- ドットファイル切替
    },
  },
  filesystem = {
    bind_to_cwd = true,
    follow_current_file = { enabled = true }, -- 現在ファイルに自動追従
    use_libuv_file_watcher = true,            -- 変更の自動反映（重ければ false に）
    filtered_items = {
      visible = false,
      hide_gitignored = true,
      hide_dotfiles = false,
    },
  },
})

