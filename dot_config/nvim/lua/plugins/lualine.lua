require("lualine").setup({
  options = {
    theme = "catppuccin",
    component_separators = { left = "|", right = "|" },
    section_separators = { left = "", right = "" },
    globalstatus = true,
  },
  sections = {
    lualine_a = {"mode"},
    lualine_b = {
      "branch",
      "diff",
      {
        "diagnostics",
        sources = {"nvim_diagnostic"}
      }
    },
    lualine_c = {
      {
        "filename",
        path = 1,
        symbols = {
          modified = "[+]",
          readonly = "[RO]",
          unnamed = "[No Name]",
        }
      }
    },
    lualine_x = {"encoding", "fileformat", "filetype"},
    lualine_y = {"progress"},
    lualine_z = {"location"}
  }
})

