-- plugins/notify.lua
local M = {}

function M.setup()
	local ok, notify = pcall(require, "notify")
	if not ok then
		return
	end

	notify.setup({
		stages = "fade_in_slide_out", -- 上品に
		timeout = 2000, -- 既定表示時間(ms)
		render = "default", -- "minimal" も可
		top_down = false, -- 新着を下→上に積む
		max_width = math.floor(vim.o.columns * 0.38),
		max_height = math.floor(vim.o.lines * 0.30),
		background_colour = "#000000", -- 半透明端末でも見やすく
		level = vim.log.levels.INFO, -- 既定レベル
	})

	vim.notify = notify

	pcall(function()
		require("telescope").load_extension("notify")
	end)

	vim.keymap.set("n", "<leader>un", "<cmd>Telescope notify<CR>", { desc = "Notifications" })
	vim.keymap.set("n", "<leader>uc", function()
		notify.dismiss({ silent = true, pending = true })
	end, { desc = "Clear notifications" })
end

return M
