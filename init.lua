--> GENERAL SETTINGS AND MAPPINGS
-- require 'impatient'
require 'general.settings'
require 'general.functions'
require 'general.mappings'
require 'general.packer'

--> THEMES and CUSTOM
require 'custom.noice_rename'.setup()
require 'custom.noiceboard'.setup()
require 'custom.noice_sus'.setup()
require 'custom.noice_comment'.setup()
require 'themes.colorschemes'.tokyodark(false)

--> LSP SETTINGS
require 'lsp.lspconfig'
require 'lsp.lsps'
require 'lsp.emmet_lsp'
require 'lsp.cmp'
