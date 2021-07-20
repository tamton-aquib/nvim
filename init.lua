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

	--> PLUG CONFIGS
	require 'config.one-liner-configs'
	require 'config.snippets'
	require 'config.telescope'
	require 'config.treesittter'
	require 'config.neorg'
	require 'config.floaterm'
	require 'config.plug-colorizer'

	--> LSP SETTINGS
	require 'lsp.lspconfig'
	require 'lsp.compe-config'
	require 'lsp.lsps'
	require 'lsp.emmet_lsp'

	vim.opt.shadafile = ""
	vim.defer_fn(function()
		vim.cmd [[ rshada! | silent! bufdo e ]]
		require 'noiceboard'.setup()
		require 'config.nvim_tree'
	end, 15)

end, 0)

vim.opt.rtp:append '~/TOOLS/custom_plugins/noiceboard'
