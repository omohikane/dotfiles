-- plugins/ddc.lua

-- 補完ソースとフィルターを有効化する設定（Denops 経由）
vim.fn["ddc#custom#patch_global"]({
  sources = { "nvim-lsp", "around", "file", "cmdline" },
  sourceOptions = {
    ["_"] = {
      matchers = { "matcher_head" },
      sorters = { "sorter_rank" },
      converters = { "converter_remove_overlap" },
    },
    ["nvim-lsp"] = {
      mark = "LSP",
      forceCompletionPattern = "\\.\\w*|:\\w*|->\\w*",
    },
    ["around"] = { mark = "A" },
    ["file"] = { mark = "F" },
    ["cmdline"] = { mark = "C" },
  },
  sourceParams = {
    ["around"] = { maxSize = 500 },
  },
})

-- コマンドライン補完の有効化
vim.api.nvim_create_autocmd("User", {
  pattern = "DenopsReady",
  once = true,
  callback = function()
    vim.fn["ddc#enable_cmdline_completion"]()
  end,
})

-- インサートモード時に有効化
vim.api.nvim_create_autocmd("InsertEnter", {
  callback = function()
    vim.fn["ddc#enable"]()
  end,
})

