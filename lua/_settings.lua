local set = vim.opt
vim.g.do_filetype_lua = 1

--> Be careful whats in this list:
for _, plugin in ipairs({ "python3_provider", "node_provider", "2html_plugin", "getscript", "getscriptPlugin",
    "gzip", "matchit", "tar", "tarPlugin", "rrhelper", "spellfile_plugin", "vimball",
    "vimballPlugin", "zip", "zipPlugin", "tutor", "rplugin", "spellfile", "tarPlugin",
    "man", "logiPat", "netrwSettings", "netrwFileHandlers", "remote_plugins" }) do
    vim.g["loaded_"..plugin] = 1
end

local ok, impatient = pcall(require, 'impatient')
if ok then impatient.enable_profile() end

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    vim.notify("Installing packer...")
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd('packadd packer.nvim')
end

require("packer").init {
    profile = { enable = true },
    display = { working_sym = "" }
}

--> General settings
set.spell = false
set.wrap = false
set.ruler = false
set.conceallevel = 2
set.mouse = "a"
set.encoding = "UTF-8"
set.fileencoding = "UTF-8"
set.scrolloff = 5
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
set.cursorline = true
set.ignorecase = true

--> Fold Settings
set.foldenable = true
set.foldmethod = "expr"
set.foldexpr = "nvim_treesitter#foldexpr()"
set.foldlevelstart = 10
vim.opt.foldtext = 'v:lua.require("essentials").simple_fold()'

--> Visual settings?
set.pumblend = 5
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

local notify_status, notify = pcall(require, "notify")
if notify_status then vim.notify = notify end

--> Test settings
-- set.copyindent = true
-- set.preserveindent = true

-- set.list = true
-- set.listchars = 'tab:▏ '
-- set.listchars = 'tab: '
-- set.lazyredraw = false
-- vim.cmd [[let &colorcolumn=join(range(81,999),",")]]
-- vim.cmd [[packadd cfilter]]
