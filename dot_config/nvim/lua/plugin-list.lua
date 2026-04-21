-- lua/plugin-list.lua
-- Single file for all plugin specifications categorized by sections

return {
	-- =========================================================================
	-- CORE & LIBRARIES
	-- =========================================================================
	{ "nvim-lua/plenary.nvim" },
	{ "MunifTanjim/nui.nvim" },
	{ "nvim-tree/nvim-web-devicons" },
	{ "vim-denops/denops.vim", lazy = false, priority = 1000 },

	-- =========================================================================
	-- UI: NAVIGATION & EXPLORERS
	-- =========================================================================
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = "Neotree",
		dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim", "nvim-tree/nvim-web-devicons" },
		config = function()
			require("config.neotree").setup()
		end,
	},
	{
		"stevearc/oil.nvim",
		cmd = "Oil",
		config = true,
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
			require("config.telescope").setup()
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		config = function()
			require("config.which_key").setup()
		end,
	},
	{
		"goolord/alpha-nvim",
		lazy = false,
		priority = 1000,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("config.alpha").setup()
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
		config = function()
			require("config.noice").setup()
		end,
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			vim.notify = require("notify")
		end,
	},

	-- =========================================================================
	-- UI: STATUS & TAB LINE
	-- =========================================================================
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
			map("n", "<Leader>bo", "<Cmd>BufferCloseAllButCurrent<CR>", { desc = "Close all but current", silent = true })
		end,
		config = function()
			require("config.barbar").setup()
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = "VeryLazy",
		config = function()
			require("config.lualine").setup()
		end,
	},
	{
		"folke/todo-comments.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("config.todo_comments").setup()
		end,
	},

	-- =========================================================================
	-- UI: COLORSCHEMES
	-- =========================================================================
	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	{ "rebelot/kanagawa.nvim", name = "kanagawa", lazy = true },
	{ "EdenEast/nightfox.nvim", name = "nightfox", lazy = true },
	{ "catppuccin/nvim", name = "catppuccin", lazy = true },
	{ "neanias/everforest-nvim", name = "everforest", lazy = true },
	{ "rose-pine/neovim", name = "rose-pine", lazy = true },
	{ "ellisonleao/gruvbox.nvim", name = "gruvbox", lazy = true },

	-- =========================================================================
	-- CODING: LSP, COMPLETION, SNIPPETS
	-- =========================================================================
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("config.lspconfig").setup()
		end,
	},
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
			require("config.cmp").setup()
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
	},
	{ "rafamadriz/friendly-snippets" },
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		config = function()
			require("config.conform").setup()
		end,
	},
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPost", "BufWritePost", "InsertLeave" },
		config = function()
			require("config.nvim_lint").setup()
		end,
	},
	{
		"j-hui/fidget.nvim",
		event = "LspAttach",
		config = true,
	},

	-- =========================================================================
	-- CODING: SYNTAX & MOTION
	-- =========================================================================
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "BufReadPost",
		config = function()
			require("config.treesitter").setup()
		end,
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		event = "VeryLazy",
		config = function()
			require("config.ufo").setup()
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		event = "BufReadPost",
		config = true,
	},
	{
		"HiPhish/rainbow-delimiters.nvim",
		event = "BufReadPost",
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = "BufReadPost",
	},
	{ "hrsh7th/vim-eft", event = { "BufReadPost", "BufNewFile" } },
	{ "unblevable/quick-scope" },

	-- =========================================================================
	-- CODING: LANGUAGES
	-- =========================================================================
	{
		"ray-x/go.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" },
		ft = "go",
		config = function()
			require("config.go").setup()
		end,
	},
	{ "mrcjkb/rustaceanvim", ft = "rust", version = "^4" },
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
	},
	{
		"elixir-tools/elixir-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		ft = { "elixir", "eelixir", "heex", "surface" },
	},

	-- =========================================================================
	-- GIT
	-- =========================================================================
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPost",
		config = function()
			require("config.gitsigns").setup()
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

	-- =========================================================================
	-- JAPANESE SUPPORT
	-- =========================================================================
	{
		"vim-skk/skkeleton",
		name = "skkeleton",
		dependencies = { "vim-denops/denops.vim" },
		lazy = false,
		config = function()
			require("config.skkeleton").setup()
		end,
	},
	{ "lambdalisue/kensaku.vim", name = "kensaku", dependencies = { "vim-denops/denops.vim" } },
	{
		"lambdalisue/kensaku-command.vim",
		dependencies = { "kensaku" },
		cmd = "Kensaku",
		init = function()
			vim.keymap.set("n", "<Leader>sk", ":<C-u>Kensaku<Space>")
		end,
	},

	-- =========================================================================
	-- TOOLS, AI & UTILITY
	-- =========================================================================
	{
		"akinsho/toggleterm.nvim",
		cmd = "ToggleTerm",
		init = function()
			local map = vim.keymap.set
			map("n", "<Leader>tt", "<Cmd>ToggleTerm direction=float<CR>", { silent = true })
			map("n", "<Leader>tg", '<Cmd>lua require("config.toggleterm").lazygit()<CR>', { silent = true })
		end,
		config = function()
			require("config.toggleterm").setup()
		end,
	},
	{
		"numToStr/Comment.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("config.comment").setup()
		end,
	},
	{
		"echasnovski/mini.surround",
		config = function()
			require("config.mini_surround").setup()
		end,
	},
	{ "windwp/nvim-ts-autotag", event = { "BufReadPost", "InsertEnter" } },
	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		init = function()
			local map = vim.keymap.set
			map("n", "<Leader>xx", "<Cmd>Trouble diagnostics toggle<CR>", { silent = true })
			map("n", "<Leader>xq", "<Cmd>Trouble qflist toggle<CR>", { silent = true })
		end,
		config = true,
	},
	{
		"epwalsh/obsidian.nvim",
		cmd = { "ObsidianQuickSwitch", "ObsidianNew", "ObsidianToday", "ObsidianOpen" },
		config = function()
			require("config.obsidian").setup()
		end,
	},
	{
		"lambdalisue/nvim-aibo",
		config = function()
			require("config.aibo").setup()
		end,
	},
	{
		"olimorris/codecompanion.nvim",
		cmd = { "CodeCompanion", "CodeCompanionChat" },
		config = function()
			require("config.codecompanion").setup()
		end,
	},
	{
		"folke/sidekick.nvim",
		cmd = { "Sidekick", "SidekickChat", "SidekickInline", "SidekickPrompt" },
	},
	{
		"swaits/zellij-nav.nvim",
		lazy = true,
		event = "VeryLazy",
		keys = {
			{ "<A-h>", "<cmd>ZellijNavigateLeftTab<cr>", { silent = true, desc = "Navigate left or tab" } },
			{ "<A-j>", "<cmd>ZellijNavigateDown<cr>", { silent = true, desc = "Navigate down" } },
			{ "<A-k>", "<cmd>ZellijNavigateUp<cr>", { silent = true, desc = "Navigate up" } },
			{ "<A-l>", "<cmd>ZellijNavigateRightTab<cr>", { silent = true, desc = "Navigate right or tab" } },
		},
		opts = {},
	},
}
