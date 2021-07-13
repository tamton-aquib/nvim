require 'general.settings'
-- vim.g.colors_name = "bruh"  --> onedark, gruvbox, tokyodark
-- vim.cmd [[au BufEnter Filetype NvimTree setlocal laststatus=0 showtabline=0]]
vim.opt.rtp:append '~/TOOLS/noice_dark'
vim.opt.rtp:append '~/TOOLS/noiceboard'
vim.g.colors_name = 'bruh'

vim.defer_fn(function()
	--> GENERAL SETTINGS AND MAPPINGS
	require 'general.mappings'
	require 'general.functions'
	require 'general.packer'

	--> THEMES AND STATUSLINE
	require 'themes.staline'
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
		]]
			-- colo bruh
		require 'config.nvim_tree'
		require'noiceboard'.setup()
	end, 15)

end, 0)

