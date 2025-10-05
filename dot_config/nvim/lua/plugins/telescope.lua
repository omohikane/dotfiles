-- lua/plugins/telescope.lua
local M = {}

local function deps_ok()
  local ok1 = pcall(require, "plenary.strings")
  local ok2 = pcall(require, "nvim-web-devicons")
  return ok1 and ok2
end

function M.setup()
  if not deps_ok() then
    vim.notify("[telescope] dependencies not ready (plenary/devicons)", vim.log.levels.WARN)
    return
  end

  vim.schedule(function()
    local ok, telescope = pcall(require, "telescope")
    if not ok then return end
    local ok_actions, actions = pcall(require, "telescope.actions")
    if not ok_actions then return end

    telescope.setup({
      defaults = {
        vimgrep_arguments = {
          "rg", "--color=never", "--no-heading", "--with-filename",
          "--line-number", "--column", "--smart-case",
        },
        prompt_prefix = "   ",
        selection_caret = "❯ ",
        sorting_strategy = "ascending",
        layout_config = { prompt_position = "top" },
        path_display = { "smart" },
        file_ignore_patterns = {
          "%.git/", "node_modules/", "target/", "build/", "dist/",
          "%.cache/", "%.venv/", "%.lock", "vendor/",
        },
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
            ["<Esc>"] = actions.close,
          },
          n = { ["q"] = actions.close },
        },
      },
      pickers = {
        find_files = (function()
          local has_fd = vim.fn.executable("fd") == 1
          return {
            find_command = has_fd
                and { "fd", "--type", "f", "--hidden", "--exclude", ".git" }
                or { "rg", "--files", "--hidden", "-g", "!.git" },
            follow = true,
            no_ignore = false,
            previewer = false,
          }
        end)(),
        live_grep = {
          additional_args = function() return { "--hidden", "--glob", "!.git/*" } end,
        },
      },
    })
  end)
end

function M.project_files()
  if not deps_ok() then return end
  local builtin = require("telescope.builtin")
  if pcall(builtin.git_files, { show_untracked = true }) then
    return
  end
  builtin.find_files({})
end

return M
