
-->  General stuff
require 'general.start'
require 'general.packer'
require 'general.autocommands'
require 'general.mappings'
require 'general.settings'

-->  UI and LSP
require('general.utils').noice_board()
require('lsp.lsp_defaults')
require('plugins').tokyodark(true)
