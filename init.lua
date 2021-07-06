-- GENERAL SETTINGS AND MAPPINGS
require 'general.settings'
require 'general.mappings'
require 'general.functions'
require 'general.packer'

-- THEMES AND STATUSLINE
-- require 'themes.onedark' --> sonokai, tokyonight
require 'themes.staline'
vim.opt.rtp:append '~/TOOLS/noice_dark'
vim.g.noice_transparency = "none"
vim.g.colors_name = "noice"  --> onedark, gruvbox, tokyodark
vim.opt.rtp:append '~/TOOLS/boot.nvim'
require'boot'.setup()
-- require 'config.vgit'
vim.g.indent_blankline_char = "▏"

-- PLUG CONFIGS
require 'config.one-liner-configs'
require 'config.snippets'
require 'config.plug-colorizer'
require 'config.telescope'
-- require 'themes.dashboard'
-- require 'plug_configs.startify'
require 'config.treesittter'
require 'config.floaterm'
require 'config.neorg'
require 'config.lirtree'

vim.opt.filetype = 'on'
vim.g.syntax = true

-- LSP SETTINGS
require 'lsp.lspconfig'
require 'lsp.compe-config'
require 'lsp.lsps'
require 'lsp.emmet_lsp'
