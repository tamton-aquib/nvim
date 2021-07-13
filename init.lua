require 'general.settings'
-- vim.g.colors_name = "bruh"  --> onedark, gruvbox, tokyodark

vim.defer_fn(function()
	--> GENERAL SETTINGS AND MAPPINGS
	require 'general.mappings'
	require 'general.functions'
	require 'general.packer'

	--> THEMES AND STATUSLINE
-- 	require 'themes.staline'
	-- require 'themes.' --> sonokai, tokyonight

	--> PLUG CONFIGS
	require 'config.one-liner-configs'
	require 'config.snippets'
	require 'config.plug-colorizer'
	require 'config.telescope'
	require 'config.treesittter'
	require 'config.floaterm'
	require 'config.neorg'

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
			colo bruh
			hi Normal guibg=#11121d
		]]
		require 'config.nvim_tree'
		require'noiceboard'.setup()
	end, 15)

end, 0)

