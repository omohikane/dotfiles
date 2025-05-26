-- lua/lsp/config.lua

local M = {}

-- nvim-cmp と連携するための capabilities を追加
local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
M.capabilities = vim.tbl_deep_extend(
  "force",
  vim.lsp.protocol.make_client_capabilities(),
  ok_cmp and cmp_nvim_lsp.default_capabilities() or {}
)

-- 各サーバー共通の on_attach 関数
M.on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  local keymap = vim.keymap.set

  keymap("n", "gd", vim.lsp.buf.definition, opts)
  keymap("n", "gr", vim.lsp.buf.references, opts)
  keymap("n", "K", vim.lsp.buf.hover, opts)
  keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
  keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
end

return M

