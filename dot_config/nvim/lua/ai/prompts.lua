-- lua/ai/prompts.lua
local M = {}

-- ~/.config/gemini/prompts
-- 環境変数 NVIM_PROMPTS_DIR があればそちらを優先
M.dir = vim.env.NVIM_PROMPTS_DIR or (vim.fn.expand("~/.config/gemini/prompts"))

local function readfile(path)
	if vim.fn.filereadable(path) == 0 then
		return nil
	end
	local lines = vim.fn.readfile(path)
	return table.concat(lines, "\n")
end

function M.load_all()
	local dir = M.dir
	local user_files = vim.fn.globpath(dir, "*.user.md", false, true)
	local prompts = {}

	for _, u in ipairs(user_files) do
		local base = vim.fn.fnamemodify(u, ":t") -- 例: "explain.user.md"
		local key = base:gsub("%.user%.md$", "") -- 例: "explain"
		local user = readfile(u) or ""
		local sys = readfile(dir .. "/" .. key .. ".system.md")
		prompts[key] = {
			prompt = user,
			system = sys,
		}
	end
	return prompts
end

return M
