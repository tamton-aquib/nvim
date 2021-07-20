--> GENERAL SETTINGS AND MAPPINGS
require 'general.settings'

vim.defer_fn(function()
	--> GENERAL SETTINGS AND MAPPINGS
	require 'general.mappings'
	require 'general.functions'
	require 'general.packer'

	--> THEMES, STATUSLINE & CUSTOM
	-- require 'themes.staline'
	require 'custom.noice_rename'.setup()
	require 'themes.colorschemes'.noice(true)
	require 'boot'.setup{}

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

	vim.opt.shadafile = ""
	vim.defer_fn(function()
		vim.cmd [[ rshada! | silent! bufdo e ]]
		-- require 'noiceboard'.setup()
		require 'config.nvim_tree'
	end, 15)

--> LSP SETTINGS
require 'lsp.lspconfig'
require 'lsp.compe-config'
require 'lsp.lsps'
require 'lsp.emmet_lsp'

