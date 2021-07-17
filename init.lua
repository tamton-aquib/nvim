require 'general.settings'
vim.cmd [[au CursorHoldI * lua vim.lsp.buf.signature_help()]]
vim.g.noice_transparency = true
-- vim.g.colors_name = "bruh"  --> onedark, gruvbox, tokyodark

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
	require 'config.telescope'
	require 'config.treesittter'
	require 'config.floaterm'
	require 'config.neorg'
	require 'config.plug-colorizer'

	--> LSP SETTINGS
	require 'lsp.lspconfig'
	require 'lsp.compe-config'
	require 'lsp.lsps'
	require 'lsp.emmet_lsp'

	vim.defer_fn(function()
		vim.cmd [[ 
			rshada!
			silent! bufdo e
			colo bruh
		]]
		require 'noiceboard'.setup()
		require 'config.nvim_tree'
	end, 15)

end, 0)

vim.opt.rtp:append '~/TOOLS/noiceboard'
vim.opt.rtp:append '~/TOOLS/noice_dark'
