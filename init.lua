--> GENERAL SETTINGS AND MAPPINGS
require 'general.paq-list'
require 'general.settings'
require 'general.mappings'
require 'general.functions'

--> THEMES AND STATUSLINE
-- require 'themes.tokyonight' --> gruvbox, onedark, sonokai, tokyonight
require 'themes.staline' -- "#ff7a93"
require 'themes.random'

--> PLUG CONFIGS
require 'plug_configs.one-liner-configs'
require 'plug_configs.snippets'
require 'plug_configs.plug-colorizer'
require 'plug_configs.telescope'
require 'plug_configs.startify'
require 'plug_configs.treesittter'
require 'plug_configs.floaterm'
require 'plug_configs.lirtree'

--> LSP SETTINGS
require 'lsp.lspconfig'
require 'lsp.compe-config'
require 'lsp.lsps'
