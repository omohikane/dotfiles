local opt = vim.opt

-- エディタの基本設定
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.number = true
opt.relativenumber = true
opt.autoindent = true
opt.smartindent = true
opt.cursorline = true

-- 検索設定
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

-- ファイル関連
opt.backup = false
opt.writebackup = false
opt.swapfile = false

-- その他
opt.clipboard = 'unnamedplus'
opt.foldmethod = 'indent'
opt.foldlevel = 99

