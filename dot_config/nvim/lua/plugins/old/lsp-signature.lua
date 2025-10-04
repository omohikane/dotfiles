-- lua/plugins/lsp-signature.lua

return function()
  require("lsp_signature").setup({
    bind = true,
    floating_window = true,
    hint_enable = false,
    handler_opts = {
      border = "rounded"
    },
    max_width = 80,
    max_height = 15,
    padding = " ",
    transparency = 10,
  })
end

