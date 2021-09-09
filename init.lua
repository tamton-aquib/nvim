--> GENERAL SETTINGS AND MAPPINGS
require 'impatient'
require 'general.packer'
require 'general.settings'
require 'general.functions'
require 'general.mappings'

--> THEMES and CUSTOM
require 'custom.noice_rename'.setup()
require 'custom.noice_board'.setup()
require 'custom.noice_sus'.setup()
require 'custom.noice_comment'.setup()
require 'themes.colorschemes'.tokyonight(false)

--> LSP SETTINGS
require 'lsp.lspconfig'
require 'lsp.lsps'
require 'lsp.emmet_lsp'
require 'lsp.cmp'
