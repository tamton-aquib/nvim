
-->  General stuff
require '_settings'
require '_packer'
require '_autocmds'
require '_mappings'

-->  UI and LSP
require('_utils').splash_screen()
require('_config').tokyodark()
require('_lsp').init()
require('_lsp').setup_servers()
