local set = vim.opt
vim.notify = require "notify"

set.fillchars = 'eob: '
set.lazyredraw = true

set.ruler = false
set.conceallevel = 2
set.mouse = "a"
set.encoding = "UTF-8"
set.fileencoding = "UTF-8"
set.termguicolors = true
set.background = "dark"
set.hidden = true
set.scrolloff = 8
set.timeoutlen = 300
set.updatetime = 500
set.hlsearch = false
set.clipboard = "unnamedplus"
set.smarttab = true
set.backup = false
set.writebackup = false
set.cmdheight = 1
set.splitright = true
set.splitbelow = true
set.pumheight = 10
set.incsearch = true
set.showmode = false
set.showtabline = 2
set.laststatus = 2
set.foldenable = true
set.foldmethod = "expr"
set.foldexpr = "nvim_treesitter#foldexpr()"
set.foldlevelstart = 25

set.iskeyword:append('-')
set.shortmess:append('c')
set.pumblend = 30
set.inccommand = "split"
set.number = true
set.relativenumber = true
set.wrap = false
set.title = true
set.titlestring = "  Editing %f..."

set.shiftwidth = 4
set.tabstop = 4
set.softtabstop = 0
set.expandtab = false
set.smartindent = true

--> TEST
-- set.shiftwidth = 4
-- set.tabstop = 4
-- set.softtabstop = 0
-- set.expandtab = true
-- set.smartindent = true
-- set.shiftwidth = 4
-- set.expandtab = true

-- set.autoindent = true
-- set.copyindent = true
-- set.breakindent = true
-- set.preserveindent = true
-- set.list = true
-- set.listchars = 'tab:▏ '
-- set.listchars = 'tab: '
-- set.cursorline = true
-- vim.cmd [[let &colorcolumn=join(range(81,999),",")]]
