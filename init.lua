
-->  General stuff
require 'general.start'
require 'general.packer'
require 'general.autocommands'
require 'general.mappings'
require 'general.settings'

-->  UI Related
require('general.utils').noice_board()
-- require('ui.colorschemes').tokyodark(true)
require('lsp.lsp_defaults')

require('themer').setup {
	colorscheme = "tokyodark",
	styles = {
		comment = { style = "italic" }
	}
}
