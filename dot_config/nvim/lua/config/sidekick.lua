-- lua/config/sidekick.lua
local M = {}

function M.setup()
	require("sidekick").setup({
		nes = { enabled = false },
		cli = {
			window = {
				layout = "right",
				split = { width = 80 },
				keys = {
					nav_left = false,
					nav_down = false,
					nav_up = false,
					nav_right = false,
					stopinsert = { "<c-\\><c-n>", "stopinsert", mode = "t", desc = "enter normal mode" },
				},
			},
			mux = {
				backend = "zellij",
				enabled = false,
			},
			tools = {
				opencode = {},
			},
		},
	})

	local map = vim.keymap.set

	map({ "n", "v" }, "<leader>at", function()
		require("sidekick.cli").toggle({ name = "opencode", focus = true })
	end, { desc = "Sidekick: Toggle opencode" })

	map({ "n", "v" }, "<leader>ao", function()
		require("sidekick.cli").focus()
	end, { desc = "Sidekick: Focus opencode" })

	map("n", "<leader>aT", function()
		require("sidekick.cli").select()
	end, { desc = "Sidekick: Select AI tool" })

	map({ "n", "v" }, "<leader>aa", function()
		require("sidekick.cli").send({ msg = "{this}" })
	end, { desc = "Sidekick: Send this" })

	map("n", "<leader>af", function()
		require("sidekick.cli").send({ msg = "{file}" })
	end, { desc = "Sidekick: Send file" })

	map("v", "<leader>as", function()
		require("sidekick.cli").send({ msg = "{selection}" })
	end, { desc = "Sidekick: Send selection" })

	map({ "n", "v" }, "<leader>ap", function()
		require("sidekick.cli").prompt()
	end, { desc = "Sidekick: Prompt library" })
end

return M
