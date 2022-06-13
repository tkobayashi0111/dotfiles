local opt = vim.opt

opt.helplang = 'ja,en'
opt.termguicolors = true
opt.number = true
opt.clipboard:append('unnamedplus')
opt.mouse = 'a'
opt.swapfile = false
opt.backup = false
opt.hidden = true
opt.autoread = true
opt.signcolumn = 'yes'
opt.cursorline = true
opt.scrolloff = 5
opt.showtabline = 2
opt.splitright = true
opt.wildmenu = true
opt.wildmode = 'list:longest'

opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.autoindent = true
opt.smartindent = true

opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true

opt.list = true
opt.listchars:append('lead:·')

require('keymap')
require('plugins')
