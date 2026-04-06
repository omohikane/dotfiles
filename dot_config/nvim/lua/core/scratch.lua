local M = {}

local scratch_buf = nil
local scratch_win = nil

function M.toggle_scratch()
	-- すでにウィンドウが開いている場合は閉じる
	if scratch_win and vim.api.nvim_win_is_valid(scratch_win) then
		vim.api.nvim_win_close(scratch_win, true)
		scratch_win = nil
		return
	end

	-- バッファがなければ作成
	if not scratch_buf or not vim.api.nvim_buf_is_valid(scratch_buf) then
		scratch_buf = vim.api.nvim_create_buf(false, true)
		vim.api.nvim_buf_set_name(scratch_buf, "[Scratch]")
		vim.api.nvim_set_option_value("buftype", "nofile", { buf = scratch_buf })
		vim.api.nvim_set_option_value("bufhidden", "hide", { buf = scratch_buf })
		vim.api.nvim_set_option_value("swapfile", false, { buf = scratch_buf })
		vim.api.nvim_set_option_value("filetype", "org", { buf = scratch_buf })
	end

	-- ウィンドウサイズと位置を計算
	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	-- フローティングウィンドウを作成 ( border="single" は幅1なので安全 )
	scratch_win = vim.api.nvim_open_win(scratch_buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "single",
	})

	-- バッファ内でのみ有効な q キーでの閉鎖設定
	vim.api.nvim_buf_set_keymap(scratch_buf, "n", "q", "<cmd>lua require('core.scratch').toggle_scratch()<CR>", {
		noremap = true,
		silent = true,
	})
-- 現在のバッファを強制的にスクラッチ（保存不要）モードにする
function M.set_scratch()
	vim.opt_local.buftype = "nofile"
	vim.opt_local.bufhidden = "hide"
	vim.opt_local.swapfile = false
	print("Current buffer set to Scratch mode (no save required)")
end

return M
