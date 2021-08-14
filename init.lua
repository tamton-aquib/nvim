--> GENERAL SETTINGS AND MAPPINGS
require 'general.settings'
require 'general.mappings'
require 'general.functions'
require 'general.packer'

--> THEMES and CUSTOM
require 'custom.noice_rename'.setup()
require 'custom.noiceboard'.setup()
require 'custom.noice_sus'.setup()
require 'themes.colorschemes'.noice(false)

--> PLUG CONFIGS
-- require 'plugins.pears'
require 'plugins.telescope'
-- require 'plugins.neorg'
require 'plugins.snippets'
require 'plugins.plug-colorizer'
require 'plugins.lir'
-- require 'plugins.nvim_tree'

--> LSP SETTINGS
require 'lsp.lspconfig'
require 'lsp.lsps'
require 'lsp.emmet_lsp'
require 'lsp.lsp_defaults'
