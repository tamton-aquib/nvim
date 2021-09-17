local set = vim.opt

vim.cmd [[ filetype plugin indent off ]]
vim.opt.spell = false
set.fillchars = 'eob: '
vim.notify = require "notify"
-- set.listchars = 'tab:▏ '
-- vim.cmd [[let &colorcolumn=join(range(81,999),",")]]
vim.cmd [[au FileType lspinfo nnoremap q <cmd>q<CR>]]
vim.cmd [[au BufEnter,FileType *.toml echo "Noice"]]

-- set.shell = '/usr/bin/bash'
set.lazyredraw = true
set.ruler = false

-- set.cursorline = true
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
set.conceallevel = 0
set.cmdheight = 1
set.splitright = true
set.splitbelow = true
set.pumheight = 10
set.incsearch = true
set.showmode = false
set.showtabline = 2
set.laststatus = 2
set.foldenable = false
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
-- set.list = true
-- set.listchars = 'tab:▏ '
-- set.listchars = 'tab: '
set.title = true
set.titlestring = "  Editing %f..."

set.tabstop = 4
set.softtabstop = 0
set.shiftwidth = 4
set.expandtab = false
set.smartindent = true
-- set.autoindent = true
-- set.copyindent = true
-- set.breakindent = true
-- set.preserveindent = true
