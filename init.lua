--> GENERAL SETTINGS AND MAPPINGS
require "general.settings"
require "general.functions"
require "general.mappings"
require "general.packer"

--> THEMES and CUSTOM
require 'custom.noice_rename'.setup()
require 'custom.noiceboard'.setup()
require 'custom.noice_sus'.setup()
require 'themes.colorschemes'.tokyonight(true)
require 'custom.noice_comment'.setup()

--> LSP SETTINGS
require 'lsp.lspconfig'
require 'lsp.lsps'
require 'lsp.emmet_lsp'
require 'lsp.cmp'
