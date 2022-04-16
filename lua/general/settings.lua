local set = vim.opt

set.cursorline = false

--> General settings
set.wrap = false
set.ruler = false
set.conceallevel = 2
set.mouse = "a"
set.encoding = "UTF-8"
set.fileencoding = "UTF-8"
set.scrolloff = 8
set.timeoutlen = 300
set.updatetime = 500
set.hlsearch = false
set.clipboard:prepend({"unnamedplus"})
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
set.laststatus = 3
set.completeopt = "menu,menuone,noselect"
set.virtualedit = "block"

--> Fold Settings
set.foldenable = true
set.foldmethod = "expr"
set.foldexpr = "nvim_treesitter#foldexpr()"
set.foldlevelstart = 10
vim.opt.foldtext = 'v:lua.require("essentials").simple_fold()'

--> Visual settings?
set.pumblend = 30
set.inccommand = "split"
set.termguicolors = true
set.background = "dark"
set.number = true
set.relativenumber = true
-- set.title = true
-- set.titlestring = "  Editing %f..."

--> Tabspace settings
set.shiftwidth = 4
set.tabstop = 4
set.softtabstop = 0
set.expandtab = true
set.smartindent = true
set.breakindent = true

--> Misc settings
set.signcolumn = "yes:1"
set.guifont = "Operator Mono Medium"
set.wildignore = { '*.pyc,__pycache__,node_modules' }
set.fillchars:append({eob=' ', fold=' ', foldopen="", foldsep=" ", foldclose=""})
set.shortmess:append({c=true, s=true, A=true, W=true})
set.iskeyword:append('-')

local ok, notify = pcall(require, "notify")
if ok then vim.notify = notify end

--> Test settings
-- set.copyindent = true
-- set.preserveindent = true

-- set.list = true
-- set.listchars = 'tab:▏ '
-- set.listchars = 'tab: '
-- set.lazyredraw = false
-- vim.cmd [[let &colorcolumn=join(range(81,999),",")]]
-- vim.cmd [[packadd cfilter]]
