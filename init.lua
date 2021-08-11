--> GENERAL SETTINGS AND MAPPINGS
require 'general.settings'
require 'general.mappings'
require 'general.functions'
require 'general.packer'

--> THEMES and CUSTOM
require 'custom.noice_rename'.setup()
require 'custom.noiceboard'.setup()
require 'custom.noice_sus'.setup()
-- require 'custom.noice_dark'.noice()

--> PLUG CONFIGS
require 'config.pears'
require 'config.telescope'
require 'config.neorg'
require 'config.snippets'
require 'config.plug-colorizer'
require 'config.nvim_tree'

--> LSP SETTINGS
require 'lsp.lspconfig'
require 'lsp.lsps'
require 'lsp.emmet_lsp'
require 'lsp.lsp_defaults'
