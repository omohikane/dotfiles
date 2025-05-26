vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    local clients = vim.lsp.get_active_clients()
    local attached = false
    for _, client in ipairs(clients) do
      if client.name == "lua_ls" then
        attached = true
        break
      end
    end

    if not attached then
      vim.lsp.start(require("lsp.lua_ls"))
    end
  end,
})

