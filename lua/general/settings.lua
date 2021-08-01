local set = vim.opt

vim.cmd [[ filetype plugin indent off ]]
vim.opt.spell = false

vim.g.loaded_gzip = false
vim.g.loaded_matchit = false
vim.g.loaded_netrwPlugin = false
vim.g.loaded_tarPlugin = false
vim.g.loaded_zipPlugin = false
vim.g.loaded_man = false
vim.g.loaded_2html_plugin = false
vim.g.loaded_remote_plugins = false

set.shell = '/usr/bin/bash'
set.lazyredraw = true

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
set.cursorline = true
set.list = true
set.listchars = 'tab:▏ '
-- set.listchars = 'tab: '
set.title = true
set.titlestring = "  Editing %f..."

set.expandtab = false
set.shiftwidth = 4
set.tabstop = 4
set.softtabstop = 4
set.autoindent = true
set.smartindent = true
set.copyindent = true
set.breakindent = true
set.preserveindent = true

-- vim.cmd [[setlocal fo-=c fo-=r fo-=o]]
-- 	print(vim.inspect(vim.fn.getpos([['"]])))
-- -- 	if vim.api.nvim_buf_line_count(0) ~= nil then
-- -- 		vim.cmd("norm '\"")
-- -- 	end
-- vim.cmd [[ autocmd FileType * :lua On_file_enter() ]]
