-- lua/config/alpha.lua
local M = {}

function M.setup()
	local ok, alpha = pcall(require, "alpha")
	if not ok then
		return
	end
	local dashboard = require("alpha.themes.dashboard")

	-- Helper: Load random ASCII art
	local function get_random_ascii()
		local ascii_dir = vim.fn.stdpath("config") .. "/ascii"
		local files = vim.fn.globpath(ascii_dir, "*.txt", false, true)
		if #files == 0 then
			return {
				"  ❖ ごきげんよう、琥珀でございます ❖",
				"   本日も素敵なひとときをお過ごしくださいませ",
			}
		end
		-- Seed the random number generator
		math.randomseed(os.time())
		local random_file = files[math.random(#files)]
		local art = {}
		local f = io.open(random_file, "r")
		if f then
			for line in f:lines() do
				table.insert(art, line)
			end
			f:close()
		end
		return art
	end

	dashboard.section.header.val = get_random_ascii()

	local session_path = vim.fn.stdpath("cache") .. "/session.vim"

	dashboard.section.buttons.val = {
		dashboard.button("e", "📄  New File", ":ene <BAR> startinsert<CR>"),
		dashboard.button("f", "🔍  Find Files", ":Telescope find_files<CR>"),
		dashboard.button("g", "📝  Find Text", ":Telescope live_grep<CR>"),
		dashboard.button("r", "🕰  Recent Files", ":Telescope oldfiles<CR>"),
		dashboard.button("s", "💾  Restore Session", ":source " .. session_path .. "<CR>"),
		dashboard.button("p", "📦  Plugins", ":Lazy<CR>"),
		dashboard.button("q", "💤  Quit", ":qa<CR>"),
	}

	dashboard.section.footer.val = "🌸 Kohaku is always with you"

	-- Only show if no file arguments are given
	vim.api.nvim_create_autocmd("VimEnter", {
		callback = function()
			if vim.fn.argc() == 0 then
				alpha.setup(dashboard.opts)
				vim.cmd("Alpha")
			end
		end,
	})
end

return M
