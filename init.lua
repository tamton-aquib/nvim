-- GENERAL SETTINGS AND MAPPINGS
require 'general.settings'
require 'general.mappings'
require 'general.functions'
require 'general.packer'

-- THEMES AND STATUSLINE
-- require 'themes.onedark' --> gruvbox, onedark, sonokai, tokyonight
require 'themes.staline'
vim.opt.rtp:append('~/TOOLS/noice_dark')
vim.g.noice_transparency = "none"
vim.g.colors_name = "noice"

-- PLUG CONFIGS
require 'plug_configs.one-liner-configs'
require 'plug_configs.snippets'
require 'plug_configs.plug-colorizer'
require 'plug_configs.telescope'
require 'plug_configs.startify'
require 'plug_configs.treesittter'
require 'plug_configs.floaterm'
require 'plug_configs.neorg'
require 'plug_configs.lirtree'

vim.opt.filetype = 'on'
vim.g.syntax = true

-- LSP SETTINGS
require 'lsp.lspconfig'
require 'lsp.compe-config'
require 'lsp.lsps'
require 'lsp.emmet_lsp'
