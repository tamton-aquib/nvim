
-->  General stuff
require '_settings'
require '_packer'
require '_autocmds'
require '_mappings'

-->  UI and LSP
require('_utils').noice_board()
require('_config').tokyodark(false)
require('_lsp').init()
require('_lsp').setup_servers()
