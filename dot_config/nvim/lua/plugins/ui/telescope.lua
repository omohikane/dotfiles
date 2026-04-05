return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
	init = function()
		local map = vim.keymap.set
		map("n", "<Leader>ff", "<Cmd>Telescope find_files<CR>", { silent = true })
		map("n", "<Leader>fg", "<Cmd>Telescope live_grep<CR>", { silent = true })
		map("n", "<Leader>fb", "<Cmd>Telescope buffers<CR>", { silent = true })
		map("n", "<Leader>fr", "<Cmd>Telescope oldfiles<CR>", { silent = true })
	end,
	config = function()
		-- From existing lua/plugins/telescope.lua
		local ok, telescope = pcall(require, "telescope")
		if not ok then
			return
		end
		local ok_actions, actions = pcall(require, "telescope.actions")
		if not ok_actions then
			return
		end

		telescope.setup({
			defaults = {
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},
				prompt_prefix = "   ",
				selection_caret = "❯ ",
				sorting_strategy = "ascending",
				layout_config = { prompt_position = "top" },
				path_display = { "smart" },
				file_ignore_patterns = {
					"%.git/",
					"node_modules/",
					"target/",
					"build/",
					"dist/",
					"%.cache/",
					"%.venv/",
					"%.lock",
					"vendor/",
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
						find_command = has_fd and { "fd", "--type", "f", "--hidden", "--exclude", ".git" } or {
							"rg",
							"--files",
							"--hidden",
							"-g",
							"!.git",
						},
						follow = true,
						no_ignore = false,
						previewer = false,
					}
				end)(),
				live_grep = {
					additional_args = function()
						return { "--hidden", "--glob", "!.git/*" }
					end,
				},
			},
		})
	end,
}
