
-->  General stuff
require 'general.start'
require 'general.packer'
require 'general.autocommands'
require 'general.mappings'
require 'general.settings'

-->  UI Related
require('general.utils').noice_board()
require('ui.colorschemes').tokyonight(false)
require('lsp.lsp_defaults')
