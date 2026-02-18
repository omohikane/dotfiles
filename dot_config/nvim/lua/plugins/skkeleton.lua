local M = {}

function M.setup()
	-- This will be a long string
	local vimscript_config = [[
	call skkeleton#config({
    \ 'globalDictionaries': [
    \   expand('~/.config/skkeleton/dicts/SKK-JISYO.L.utf8'),
    \   expand('~/.config/skkeleton/dicts/SKK-JISYO.jinmei.utf8'),
    \   expand('~/.config/skkeleton/dicts/SKK-JISYO.propernoun.utf8'),
    \   expand('~/.config/skkeleton/dicts/SKK-JISYO.geo.utf8'),
    \   expand('~/.config/skkeleton/dicts/SKK-JISYO.station.utf8'),
    \   expand('~/.config/skkeleton/dicts/SKK-JISYO.itaiji.utf8'),
    \ ],
    \ 'userDictionary': expand('~/.config/skkeleton/SKK-JISYO.user'),
    \ 'eggLikeNewline': v:true,
    \ 'registerConvertResult': v:true,
    \ 'immediatelyCancel': v:false,
    \ 'immediatelyCandidates': v:true,
    \ 'showCandidatesCount': 10,
    \ 'databasePath': expand('~/.config/skkeleton/database.db'),
    \ })
	autocmd User DenopsPluginPost:skkeleton call skkeleton#initialize()
	]]

	vim.cmd(vimscript_config)

	-- キーマップの設定
	vim.keymap.set({ "i", "c" }, "<C-q>", "<Plug>(skkeleton-toggle)", {
		desc = "Toggle skkeleton",
		silent = true,
	})
	vim.keymap.set({ "i", "c" }, "<C-_>", "<Plug>(skkeleton-toggle)", {
		desc = "Toggle skkeleton (Ctrl + /)",
		silent = true,
	})
	vim.keymap.set({ "i", "c" }, "<Leader>j", "<Plug>(skkeleton-toggle)", {
		desc = "Toggle skkeleton (Leader + j)",
		silent = true,
	})
end

-- lualine用の表示関数
function M.mode_status()
	if vim.fn.exists("*skkeleton#mode") == 0 then
		return ""
	end
	local mode = vim.fn["skkeleton#mode"]()
	local symbols = {
		hira = "あ",
		kata = "ア",
		hankata = "ｱ",
		zenkaku = "全",
		abbrev = "a",
	}
	return symbols[mode] or ""
end

return M