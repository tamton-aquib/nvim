require 'general.settings'
-- require 'themes.dashboard'
require 'config.startify'
-- require 'themes.sonokai' --> sonokai, tokyonight

vim.opt.rtp:append '~/TOOLS/noice_dark'
vim.g.noice_transparency = true
vim.g.colors_name = "bruh"  --> onedark, gruvbox, tokyodark
-- vim.g.colors_name = 'tokyodark'

vim.defer_fn(function()
	-- GENERAL SETTINGS AND MAPPINGS
	require 'general.mappings'
	require 'general.functions'
	require 'general.packer'

	-- THEMES AND STATUSLINE
-- 	require 'themes.staline'

	-- PLUG CONFIGS
	require 'config.one-liner-configs'
	require 'config.snippets'
	require 'config.plug-colorizer'
	require 'config.telescope'
	require 'config.treesittter'
	require 'config.floaterm'
	require 'config.neorg'
	require 'config.lirtree'

	-- LSP SETTINGS
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
	end, 15)

end, 0)

