return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		local function get_ascii_path()
			local files = vim.fn.glob(vim.fn.stdpath("config") .. "/ascii/*.txt", false, true)
			if #files == 0 then
				return nil
			end
			math.randomseed(os.time())
			return files[math.random(#files)]
		end

		local function get_ascii_content(path)
			if not path then
				return { "NEOVIM" }
			end
			local lines = {}
			local f = io.open(path, "r")
			if not f then
				return { "NEOVIM" }
			end
			for line in f:lines() do
				-- ANSI エスケープシーケンスを除去
				local clean = line:gsub("\x1b%[[0-9;]*m", "")
				-- 制御文字（エスケープ）そのものを除去
				clean = clean:gsub("\x1b", "")
				table.insert(lines, clean)
			end
			f:close()
			return lines
		end

		local ascii_path = get_ascii_path()
		local ascii_content = get_ascii_content(ascii_path)

		-- ヘッダー (Text 形式で安全に表示)
		local header = {
			type = "text",
			val = ascii_content,
			opts = {
				hl = "Type",
				position = "center",
			},
		}

		-- 中央のボタン項目
		local buttons = {
			type = "group",
			val = {
				dashboard.button("f", "󰈞 " .. " Find file", ":Telescope find_files <CR>"),
				dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("r", "󰄉 " .. " Recent files", ":Telescope oldfiles <CR>"),
				dashboard.button("g", "󰊄 " .. " Live grep", ":Telescope live_grep <CR>"),
				dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
				dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
				dashboard.button("s", " " .. " Restore Session", ":source " .. vim.fn.stdpath("cache") .. "/session.vim<CR>"),
				dashboard.button("q", "󰅚 " .. " Quit", ":qa<CR>"),
			},
			opts = { spacing = 1 },
		}

		-- フッター
		local footer = {
			type = "text",
			val = { "Welcome back!" },
			opts = { hl = "Comment", position = "center" },
		}

		-- レイアウト設定
		local config = {
			layout = {
				{ type = "padding", val = 2 },
				header,
				{ type = "padding", val = 2 },
				buttons,
				{ type = "padding", val = 1 },
				footer,
			},
			opts = {
				margin = 5,
			},
		}

		alpha.setup(config)

		-- 起動後にフッターを更新（遅延実行）
		vim.api.nvim_create_autocmd("User", {
			pattern = "LazyVimStarted",
			callback = function()
				local stats = require("lazy").stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				footer.val = { "Loaded " .. stats.count .. " plugins in " .. ms .. "ms" }
				pcall(vim.cmd.AlphaRedraw)
			end,
		})
	end,
}
