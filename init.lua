-->  General stuff
require '_settings'
vim.g.mapleader = " "
require("lazy").setup("plugins")
require '_nice'
require '_autocmds'
require '_mappings'

-->  UI and LSP
require('_utils').splash_screen()
require('_config').tokyodark(false)
require('_lsp').init()
require('_lsp').setup_servers()
