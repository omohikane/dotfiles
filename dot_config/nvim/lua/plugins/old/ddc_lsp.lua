-- lua/plugins/ddc_lsp.lua
local M = {}

function M.setup()
  pcall(vim.fn["dpp#ext_action"], "lazy", "load", { names = { "ddc.vim" } })
  local patch = vim.fn["ddc#custom#patch_global"]

  local cur = vim.fn["ddc#custom#get_global"]()
  local sources = cur.sources or {}
  local function uniq_prepend(xs, x)
    local seen = {}; for _, v in ipairs(xs) do seen[v] = true end
    if not seen[x] then table.insert(xs, 1, x) end
    return xs
  end
  sources = uniq_prepend(sources, "nvim-lsp")
  patch({ sources = sources })

  patch({
    sourceOptions = {
      ["nvim-lsp"] = {
        mark = "LSP",
        minAutoCompleteLength = 1,
        forceCompletionPattern = [[\.\w*|\:\:\w*|->\w*]],
      },
      ["around"] = { mark = "A" },
      ["buffer"] = { mark = "B" },
    },
    sourceParams = {
      ["nvim-lsp"] = {
        enableResolveItem = true,
        enableAdditionalTextEdit = true,
      },
    },
  })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("OjouDdcLsp", { clear = true }),
    callback = function(args)
      vim.fn["ddc#enable"]({ buffer = args.buf })
    end,
  })
end

return M

