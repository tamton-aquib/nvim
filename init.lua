require 'general.settings'
vim.cmd [[au CursorHoldI * lua vim.lsp.buf.signature_help()]]

vim.defer_fn(function()
	--> GENERAL SETTINGS AND MAPPINGS
	require 'general.mappings'
	require 'general.functions'
	require 'general.packer'

	--> THEMES AND STATUSLINE
	require 'themes.staline'
	require 'themes.colorschemes'.tokyonight(true)
	require 'custom.noice_rename'.setup()

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
		vim.cmd [[ 
			rshada!
			silent! bufdo e
		]]
		require 'noiceboard'.setup()
		require 'config.nvim_tree'
	end, 15)

end, 0)

vim.opt.rtp:append '~/TOOLS/custom_plugins/noiceboard'
vim.opt.rtp:append '~/TOOLS/custom_plugins/noice_dark'
