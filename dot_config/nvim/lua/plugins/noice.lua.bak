-- lua/plugins/noice.lua

local ok, noice = pcall(require, "noice")
if not ok then
  vim.notify("Noice not loaded", vim.log.levels.WARN)
  return
end

noice.setup({
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
    progress = { enabled = false },
  },
  messages = { enabled = false },
  cmdline = { enabled = false },
  views = {},
  presets = {},
})

