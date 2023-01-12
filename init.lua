
-->  General stuff
require '_settings'
require '_autocmds'
require '_mappings'
require('lazy').setup("plugins")

-->  UI and LSP
require '_nice'
require('_utils').splash_screen()
require('_config').tokyodark(false)
require('_lsp').init()
require('_lsp').setup_servers()
