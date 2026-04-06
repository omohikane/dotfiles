return {
	"nvim-treesitter/nvim-treesitter",
	-- Nvim 0.11.7 向けに、最も安定していた時点の情報を保持
	branch = "master",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	cmd = { "TSUpdate", "TSUpdateSync", "TSInstall", "TSInstallSync", "TSUninstall", "TSModuleInfo" },
	config = function()
		-- モジュールの存在を確認してから実行
		local ok, configs = pcall(require, "nvim-treesitter.configs")
		if ok then
			configs.setup({
				ensure_installed = {
					"lua",
					"vim",
					"vimdoc",
					"query",
					"typescript",
					"javascript",
					"go",
					"rust",
					"elixir",
					"html",
					"css",
				},
				auto_install = true,
				highlight = {
					enable = true,
				},
				indent = { enable = true },
			})
		else
			-- モジュールがない場合は基本設定のみ試みる
			require("nvim-treesitter").setup({
				highlight = { enable = true },
				indent = { enable = true },
			})
		end
	end,
}
