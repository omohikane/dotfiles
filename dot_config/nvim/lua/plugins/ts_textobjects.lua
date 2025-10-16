-- plugins/ts_textobjects.lua
local M = {}

function M.setup()
	local ok, ts_configs = pcall(require, "nvim-treesitter.configs")
	if not ok then
		return
	end

	ts_configs.setup({
		textobjects = {
			select = {
				enable = true,
				lookahead = true, -- 対象に先読みジャンプ
				keymaps = {
					["af"] = "@function.outer",
					["if"] = "@function.inner",
					["ac"] = "@class.outer",
					["ic"] = "@class.inner",
					-- （お好みで）
					["aa"] = "@parameter.outer",
					["ia"] = "@parameter.inner",
					["ab"] = "@block.outer",
					["ib"] = "@block.inner",
				},
				selection_modes = {
					["@parameter.outer"] = "v", -- charwise
					["@function.outer"] = "V", -- linewise
					["@class.outer"] = "V",
				},
				include_surrounding_whitespace = true,
			},

			move = {
				enable = true,
				set_jumps = true,
				goto_next_start = {
					["]m"] = "@function.outer",
					["]]"] = "@class.outer",
				},
				goto_previous_start = {
					["[m"] = "@function.outer",
					["[["] = "@class.outer",
				},
				-- （必要なら end へのジャンプも）
				-- goto_next_end = { ["]M"] = "@function.outer" },
				-- goto_previous_end = { ["[M"] = "@function.outer" },
			},

			swap = {
				enable = true,
				swap_next = {
					["g>p"] = "@parameter.inner",
				},
				swap_previous = {
					["g<p"] = "@parameter.inner",
				},
			},
		},
	})
end

return M
