local set = vim.opt
local ok, impatient = pcall(require, 'impatient')
if ok then impatient.enable_profile() end

vim.g.neovide_confirm_quit = true
vim.g.neovide_transparency = 0.7
vim.g.neovide_remember_window_size = true

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    print("Installing lazy.nvim...")
    vim.fn.system({
        "git", "clone", "--filter=blob:none", "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

--> General settings
set.exrc = true
set.spell = false
set.wrap = false
set.ruler = false
set.conceallevel = 2
set.mouse = "a"
set.showcmd = false
-- set.encoding = "UTF-8"
-- set.fileencoding = "UTF-8"
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
set.pumblend = 20
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
-- set.guifont = "JetBrainsMono Nerd Font"
set.guifont = "JetBrainsMonoNerdFontComplete Nerd Font"
set.wildignore = { '*.pyc,__pycache__,node_modules,*.lock' }
set.fillchars:append({eob=' ', fold=' ', foldopen="", foldsep=" ", foldclose=""})
set.shortmess:append({c=true, s=true, A=true, W=true, I=true})
set.iskeyword:append('-')

vim.schedule(function()
    local ess_status, essentials = pcall(require, "essentials")
    if ess_status then
        vim.ui.input = essentials.ui_input
        vim.ui.select = essentials.ui_select
        vim.notify = essentials.ui_notify
    end
end)

--> Test settings
-- set.copyindent = true
-- set.preserveindent = true

-- set.list = true
-- set.listchars = 'tab:▏ ' -- ''
-- vim.g.markdown_fenced_languages = {'rust'}
