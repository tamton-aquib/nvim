--> GENERAL SETTINGS AND MAPPINGS
require 'general.settings'
require 'general.mappings'
require 'general.functions'
require 'general.packer'

--> THEMES AND STATUSLINE
-- require 'themes.sonokai' --> sonokai, tokyonight
require 'themes.staline'
vim.opt.rtp:append '~/TOOLS/noice_dark'
vim.g.noice_transparency = "none"
vim.g.colors_name = "noice"  --> onedark, gruvbox, tokyodark

--> PLUG CONFIGS
require 'config.one-liner-configs'
require 'config.snippets'
require 'config.plug-colorizer'
require 'config.telescope'
require 'themes.dashboard'
-- require 'config.startify'
require 'config.treesittter'
require 'config.floaterm'
require 'config.neorg'
require 'config.lirtree'

--> LSP SETTINGS
require 'lsp.lspconfig'
require 'lsp.compe-config'
require 'lsp.lsps'
require 'lsp.emmet_lsp'

