-- lua/config/nvim_lint.lua
local M = {}

function M.setup()
	local ok, lint = pcall(require, "lint")
	if not ok or type(lint) ~= "table" then
		return
	end

	local has = function(exe)
		return vim.fn.executable(exe) == 1
	end
	lint.linters_by_ft = {
		lua = has("luacheck") and { "luacheck" } or nil,
		sh = has("shellcheck") and { "shellcheck" } or nil,
		python = has("ruff") and { "ruff" } or nil,
		javascript = { "eslint_d" },
		typescript = { "eslint_d" },
		javascriptreact = { "eslint_d" },
		typescriptreact = { "eslint_d" },
		go = has("golangci_lint") and { "golangci-lint" } or nil,
		rust = has("clippy") or nil,
		elixir = has("credo") or nil,
		yaml = has("yamllint") and { "yamllint" } or nil,
	}

	local aug = vim.api.nvim_create_augroup("OjouNvimLint", { clear = true })
	vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
		group = aug,
		callback = function()
			local lok, l = pcall(require, "lint")
			if lok then
				l.try_lint()
			end
		end,
	})
end

return M
