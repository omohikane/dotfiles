local M = {}

function M.setup()
    -- skkeletonの設定（Luaで直接記述）
    -- ※ Denopsが起動していないと関数が存在しない可能性があるから、pcallかautocmd経由が安全よ
    local function config()
        if vim.fn.exists('*skkeleton#config') == 1 then
            vim.fn["skkeleton#config"]({
                globalDictionaries = {
                    vim.fn.expand('~/.config/skkeleton/dicts/SKK-JISYO.L.utf8'),
                    vim.fn.expand('~/.config/skkeleton/dicts/SKK-JISYO.jinmei.utf8'),
                    vim.fn.expand('~/.config/skkeleton/dicts/SKK-JISYO.propernoun.utf8'),
                    vim.fn.expand('~/.config/skkeleton/dicts/SKK-JISYO.geo.utf8'),
                    vim.fn.expand('~/.config/skkeleton/dicts/SKK-JISYO.station.utf8'),
                    vim.fn.expand('~/.config/skkeleton/dicts/SKK-JISYO.itaiji.utf8'),
                },
                userDictionary = vim.fn.expand('~/.config/skkeleton/SKK-JISYO.user'),
                eggLikeNewline = true,
                registerConvertResult = true,
                immediatelyCancel = false,
                showCandidatesCount = 10,
                databasePath = vim.fn.expand('~/.config/skkeleton/database.db'),
            })
        end
    end

    -- Denops起動後に設定と初期化を行う
    vim.api.nvim_create_autocmd("User", {
        pattern = "skkeleton-initialize-pre",
        callback = function()
            config()
        end,
    })

    -- キーマップの設定
    local opts = { silent = true }
    vim.keymap.set({ "i", "c" }, "<C-q>", "<Plug>(skkeleton-toggle)", opts)
    vim.keymap.set({ "i", "c" }, "<C-_>", "<Plug>(skkeleton-toggle)", opts)
    -- Leader+j は、Leaderが設定された後に有効になるようにしなさいよ
    vim.keymap.set({ "i", "c" }, "<Leader>j", "<Plug>(skkeleton-toggle)", opts)
end

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
