--> GENERAL SETTINGS AND MAPPINGS
require 'general.settings'
require 'general.paq-list'
require 'general.mappings'
require 'general.functions'

--> THEMES AND STATUSLINE
-- require 'themes.gruvbox' --> gruvbox, onedark, sonokai, tokyonight
require 'themes.staline'
vim.cmd [[colo taj_scheme]]

--> PLUG CONFIGS
require 'plug_configs.one-liner-configs'
require 'plug_configs.snippets'
require 'plug_configs.plug-colorizer'
require 'plug_configs.telescope'
require 'plug_configs.startify'
require 'plug_configs.treesittter'
require 'plug_configs.floaterm'
require 'plug_configs.lirtree'

vim.cmd('syntax enable')
vim.cmd("filetype plugin indent on")

--> LSP SETTINGS
require 'lsp.lspconfig'
require 'lsp.compe-config'
require 'lsp.lsps'
