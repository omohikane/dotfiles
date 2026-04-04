-- lua/plugins_spec.lua
-- This file is a translation of dein.toml for lazy.nvim
-- Robust version to handle mixed M.setup() and lazy spec styles

local function load_config(name)
	local ok, plugin = pcall(require, "plugins." .. name)
	if not ok then
		-- If the file doesn't exist, we just skip it
		return
	end
	if type(plugin) ~= "table" then
		return
	end

	-- Custom check: if it has .setup(), call it (Old style)
	-- If it has .config(), call it (Some of your files are specs)
	if type(plugin.setup) == "function" then
		plugin.setup()
	elseif type(plugin.config) == "function" then
		plugin.config()
	elseif plugin[1] and type(plugin.config) ~= "function" then
		-- It's a spec but has no config function, nothing to do here
		-- because lazy.nvim handles the main spec
	end
end

return {
	-- Core
	{ "vim-denops/denops.vim", lazy = false, priority = 1000 },

	-- Completion (nvim-cmp)
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			{ "uga-rosa/cmp-skkeleton", name = "cmp-skkeleton" },
		},
		config = function()
			load_config("cmp")
		end,
	},

	-- Snippets
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
	},
	{ "rafamadriz/friendly-snippets" },

	-- UI Color Schemes
	{ "folke/tokyonight.nvim", name = "tokyonight", lazy = true },
	{ "rebelot/kanagawa.nvim", name = "kanagawa", lazy = true },
	{ "EdenEast/nightfox.nvim", name = "nightfox", lazy = true },
	{ "catppuccin/nvim", name = "catppuccin", lazy = true },
	{ "neanias/everforest-nvim", name = "everforest", lazy = true },
	{ "rose-pine/neovim", name = "rose-pine", lazy = true },
	{ "ellisonleao/gruvbox.nvim", name = "gruvbox", lazy = true },

	-- UI Libraries
	{ "nvim-lua/plenary.nvim" },
	{ "MunifTanjim/nui.nvim" },
	{ "nvim-tree/nvim-web-devicons" },

	-- UI Explorer
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = "Neotree",
		dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim", "nvim-tree/nvim-web-devicons" },
		config = function()
			load_config("neotree")
		end,
	},
	{
		"stevearc/oil.nvim",
		cmd = "Oil",
		config = function()
			load_config("oil")
		end,
	},
	{
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
			load_config("telescope")
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			load_config("which_key")
		end,
	},

	-- UI Status & Tab Line
	{
		"romgrk/barbar.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", "lewis6991/gitsigns.nvim" },
		event = "VeryLazy",
		init = function()
			vim.g.barbar_auto_setup = false
			local map = vim.keymap.set
			map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", { silent = true })
			map("n", "<A-.>", "<Cmd>BufferNext<CR>", { silent = true })
			map("n", "<A-c>", "<Cmd>BufferClose<CR>", { silent = true })
			map("n", "<A-p>", "<Cmd>BufferPin<CR>", { silent = true })
			map("n", "<C-p>", "<Cmd>BufferPick<CR>", { silent = true })
		end,
		config = function()
			load_config("barbar")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		config = function()
			load_config("lualine")
		end,
	},

	-- Motion
	{
		"hrsh7th/vim-eft",
		event = { "BufReadPost", "BufNewFile" },
	},
	{
		"unblevable/quick-scope",
		event = "VeryLazy",
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "TelescopePrompt", "neo-tree", "help" },
				callback = function()
					vim.cmd("silent! QuickScopeDisable")
				end,
			})
		end,
	},

	-- Git
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPost",
		config = function()
			load_config("gitsigns")
		end,
	},
	{
		"lambdalisue/gin.vim",
		dependencies = { "vim-denops/denops.vim" },
		cmd = { "Gin", "GinStatus", "GinDiff", "GinLog", "GinBranch", "GinBrowse", "GinBlame" },
		init = function()
			local map = vim.keymap.set
			map("n", "<Leader>gg", "<Cmd>GinStatus<CR>", { silent = true })
			map("n", "<Leader>gc", "<Cmd>Gin commit<CR>", { silent = true })
			map("n", "<Leader>gl", "<Cmd>GinLog<CR>", { silent = true })
			map("n", "<Leader>gd", "<Cmd>GinDiff<CR>", { silent = true })
			map("n", "<Leader>gb", "<Cmd>GinBlame<CR>", { silent = true })
		end,
	},

	-- Syntax
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "BufReadPost",
		cmd = { "TSUpdate", "TSUpdateSync", "TSInstall", "TSInstallSync", "TSUninstall", "TSModuleInfo" },
		config = function()
			load_config("nvim-treesitter")
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = "BufReadPost",
		config = function()
			load_config("ibl")
		end,
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		event = "BufReadPost",
		config = function()
			load_config("rainbow_delimiters")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = "BufReadPost",
		config = function()
			load_config("ts_context")
		end,
	},

	-- LSP
	{
		"neovim/nvim-lspconfig",
		config = function()
			load_config("lspconfig")
			-- Also load your custom LSP setup logic
			require("lsp").setup()
		end,
	},
	{
		"j-hui/fidget.nvim",
		event = "LspAttach",
		config = function()
			load_config("fidget")
		end,
	},

	-- Coding
	{
		"ray-x/go.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" },
		ft = "go",
		config = function()
			pcall(require, "lang.go") -- Uses setup() pattern usually
			load_config("go")
		end,
	},
	{
		"mrcjkb/rustaceanvim",
		ft = "rust",
		version = "^4",
	},
	{
		"elixir-tools/elixir-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		ft = { "elixir", "eelixir", "heex", "surface" },
		config = function()
			pcall(require, "lang.elixir")
		end,
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
		config = function()
			load_config("ts_tools")
		end,
	},

	-- Formatter & Linter
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		config = function()
			load_config("conform")
		end,
	},
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPost", "BufWritePost", "InsertLeave" },
		config = function()
			load_config("nvim_lint")
		end,
	},

	-- Terminal
	{
		"akinsho/toggleterm.nvim",
		cmd = "ToggleTerm",
		init = function()
			local map = vim.keymap.set
			map("n", "<Leader>tt", "<Cmd>ToggleTerm direction=float<CR>", { silent = true })
			map("n", "<Leader>tv", "<Cmd>ToggleTerm direction=vertical size=80<CR>", { silent = true })
			map("n", "<Leader>th", "<Cmd>ToggleTerm direction=horizontal size=12<CR>", { silent = true })
			map("n", "<Leader>tg", '<Cmd>lua require("plugins.toggleterm").lazygit()<CR>', { silent = true })
		end,
		config = function()
			load_config("toggleterm")
		end,
	},

	-- Edit
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			load_config("comment")
		end,
	},
	{
		"echasnovski/mini.surround",
		config = function()
			load_config("mini_surround")
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = { "BufReadPost", "InsertEnter" },
		config = function()
			load_config("ts_autotag")
		end,
	},

	-- Diagnostics
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = "Trouble",
		init = function()
			local map = vim.keymap.set
			map("n", "<Leader>xx", "<Cmd>Trouble diagnostics toggle<CR>", { silent = true })
			map("n", "<Leader>xq", "<Cmd>Trouble qflist toggle<CR>", { silent = true })
		end,
		config = function()
			load_config("trouble")
		end,
	},

	-- AI Tools
	{
		"olimorris/codecompanion.nvim",
		cmd = { "CodeCompanion", "CodeCompanionChat" },
		dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
		config = true,
	},
	{
		"folke/sidekick.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
		cmd = { "Sidekick", "SidekickChat", "SidekickInline", "SidekickPrompt" },
		config = function()
			load_config("sidekick")
		end,
	},

	-- Japanese
	{
		"lambdalisue/kensaku.vim",
		name = "kensaku",
		dependencies = { "vim-denops/denops.vim" },
	},
	{
		"lambdalisue/kensaku-command.vim",
		dependencies = { "kensaku" },
		cmd = "Kensaku",
		init = function()
			vim.keymap.set("n", "<Leader>sk", ":<C-u>Kensaku<Space>")
		end,
	},
	{
		"vim-skk/skkeleton",
		name = "skkeleton",
		dependencies = { "vim-denops/denops.vim" },
		lazy = false,
		config = function()
			load_config("skkeleton")
		end,
	},

	-- Obsidian
	{
		"epwalsh/obsidian.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = { "ObsidianQuickSwitch", "ObsidianNew", "ObsidianToday", "ObsidianOpen" },
		config = function()
			load_config("obsidian")
		end,
	},
}
