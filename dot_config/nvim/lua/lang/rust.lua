vim.g.rustaceanvim = {
  tools = { hover_actions = { auto_focus = true } },
  server = { default_settings = { ["rust-analyzer"] = { checkOnSave = { command = "clippy" } } } },
}
