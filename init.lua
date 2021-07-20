vim.opt.rtp:append '~/TOOLS/custom_plugins/noiceboard'

--> GENERAL SETTINGS AND MAPPINGS
require 'general.settings'
require 'general.mappings'
require 'general.functions'
require 'general.packer'

--> THEMES, STATUSLINE & CUSTOM
require 'themes.staline'
require 'custom.noice_rename'.setup()
require 'themes.colorschemes'.noice(true)
require 'noiceboard'.setup()

--> PLUG CONFIGS
require 'config.one-liner-configs'
require 'config.snippets'
require 'config.telescope'
require 'config.treesittter'
require 'config.neorg'
require 'config.floaterm'
require 'config.plug-colorizer'
require 'config.nvim_tree'

--> LSP SETTINGS
require 'lsp.lspconfig'
require 'lsp.compe-config'
require 'lsp.lsps'
require 'lsp.emmet_lsp'
