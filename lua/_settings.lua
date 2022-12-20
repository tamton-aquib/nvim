local set = vim.opt

--> Be careful whats in this list:
for _, plugin in ipairs({ "python3_provider", "node_provider", "2html_plugin", "getscript", "getscriptPlugin",
    "gzip", "matchit", "tar", "tarPlugin", "rrhelper", "spellfile_plugin", "vimball",
    "vimballPlugin", "zip", "zipPlugin", "tutor", "rplugin", "spellfile", "tarPlugin",
    "man", "logiPat", "netrwSettings", "netrwFileHandlers", "remote_plugins" }) do
    vim.g["loaded_"..plugin] = 1
end

local ok, impatient = pcall(require, 'impatient')
if ok then impatient.enable_profile() end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    print("Installing lazy.nvim...")
    vim.fn.system({
        "git", "clone", "--filter=blob:none", "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)

-- local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
-- if vim.fn.isdirectory(install_path) == 0 then
    -- vim.notify("Installing packer...")
    -- vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    -- vim.cmd('packadd packer.nvim')
-- end

--> General settings
set.exrc = true
set.spell = false
set.wrap = false
set.ruler = false
set.conceallevel = 2
set.mouse = "a"
set.encoding = "UTF-8"
set.fileencoding = "UTF-8"
set.scrolloff = 5
set.timeoutlen = 300
set.updatetime = 300
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
set.ignorecase = true
set.equalalways = false

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
-- set.guifont = "JetBrainsMonoNerdFontComplete Nerd Font Mono:h10"
set.guifont = "Operator Mono Lig Book:h10"
set.wildignore = { '*.pyc,__pycache__,node_modules,*.lock' }
set.fillchars:append({eob=' ', fold=' ', foldopen="", foldsep=" ", foldclose=""})
set.shortmess:append({c=true, s=true, A=true, W=true})
set.iskeyword:append('-')

--> OVERRIDING Default vim globals
-- local notify_status, notify = pcall(require, "notify")
-- if notify_status then vim.notify = notify end

local ess_status, essentials = pcall(require, "essentials")
if ess_status then
    vim.ui.input = essentials.ui_input
    vim.ui.select = essentials.ui_select
    vim.notify = essentials.ui_notify
end

--> Test settings
-- set.copyindent = true
-- set.preserveindent = true

-- set.list = true
-- set.listchars = 'tab:▏ ' -- ''
-- vim.cmd [[let &colorcolumn=join(range(81,999),",")]]
-- vim.cmd [[packadd cfilter]]
-- vim.g.markdown_fenced_languages = {'rust'}
