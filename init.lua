--> GENERAL SETTINGS AND MAPPINGS
require 'general.settings'
require 'general.mappings'
require 'general.functions'
require 'general.packer'

--> THEMES, STATUSLINE & CUSTOM
require 'custom.noice_rename'.setup()
require 'themes.colorschemes'.noice(false)
require 'noiceboard'.setup()
require 'custom.noice_sus'.setup()

--> PLUG CONFIGS
require 'config.pears'
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
require 'lsp.lsp_defaults'

-- vim.opt.shadafile = "NONE" -- TODO: do this in ./lua/general/settings.lua later
-- vim.cmd [[ rshada! ]]
