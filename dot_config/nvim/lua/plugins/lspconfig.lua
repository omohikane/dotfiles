-- lua/plugins/lspconfig.lua
local M = {}

function M.setup()
  if not pcall(require, "lspconfig") then return end

  local ok, user = pcall(require, "lsp")
  if ok and type(user) == "table" and type(user.setup) == "function" then
    user.setup()
  end

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("OjouLspKeymaps", { clear = true }),
    callback = function(ev)
      local map = function(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, silent = true, desc = "LSP: " .. desc })
      end
      map("gd", vim.lsp.buf.definition,       "Go to definition")
      map("gD", vim.lsp.buf.declaration,      "Go to declaration")
      map("gr", vim.lsp.buf.references,       "References")
      map("gI", vim.lsp.buf.implementation,   "Implementation")
      map("K",  vim.lsp.buf.hover,            "Hover")
      map("<Leader>rn", vim.lsp.buf.rename,   "Rename")
      map("<Leader>ca", vim.lsp.buf.code_action, "Code action")
      map("[d", vim.diagnostic.goto_prev,     "Prev diagnostic")
      map("]d", vim.diagnostic.goto_next,     "Next diagnostic")
      if vim.lsp.inlay_hint then
        map("<Leader>uh", function()
          local b = ev.buf
          local cur = vim.lsp.inlay_hint.is_enabled(b)
          vim.lsp.inlay_hint.enable(not cur, { bufnr = b })
        end, "Toggle inlay hints")
      end
    end,
  })
end

return M

