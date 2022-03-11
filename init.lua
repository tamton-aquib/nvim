
-->  General stuff
require 'general.start'
require 'general.packer'
require 'general.autocommands'
require 'general.mappings'
require 'general.settings'

-->  UI and LSP
require('general.utils').noice_board()
require('lsp.lsp_defaults')
require("themer").setup { enable_installer = true }
require("ui.colorschemes").tokyodark(true)
