
require("packer").startup { function(use)

	-->  Testing and temporary
	use { 'kyazdani42/nvim-tree.lua', config = function() require 'plugins.nvim_tree' end , cmd='NvimTreeToggle'}
	use { 'williamboman/nvim-lsp-installer', config=function() require "lsp.lsps" end }
	use { '~/TOOLS/staline.nvim' , config = function() require"themes.staline" end}
	-- use { 'tamton-aquib/staline.nvim', branch='beta' , config = function() require"themes.staline" end}
	-- use { '~/TOOLS/nvim-cmp' , after="LuaSnip", config=function() require 'lsp.cmp' end }
	-- use { '~/TOOLS/nvim_stuff/nvim-lspmanager', branch="dev", config=function() require"lsp.lsps" end}
	-- use { 'MordechaiHadad/nvim-lspmanager', branch="dev", config=function() require"lsp.lsps" end}
	-- use { 'shadmansaleh/lualine.nvim', config=function() require "lualine".setup() end }

	-- use { '~/TOOLS/staline.nvim' , config = function() require"themes.staline" end}
	-- use({
		-- "NTBBloodbath/galaxyline.nvim",
		-- config = function()
			-- require("galaxyline.themes.eviline")
		-- end,
	-- })
	-- use { 'tamago324/lir.nvim' , config = function() require"plugins.lir" end, after="nvim-web-devicons" }
	use { 'folke/zen-mode.nvim', cmd='ZenMode', config=function() require "zen-mode".setup() end }
	use { 'tamton-aquib/essentials.nvim' }

	use { 'max397574/better-escape.nvim', config=function() require"better_escape".setup { } end }
	use { 'nathom/filetype.nvim' }
	-- use { 'windwp/floatline.nvim', config=function() require"floatline".setup() end }
	-- use { '~/TOOLS/staline.nvim' , config = function() require"themes.staline" end}
	-- use { "AckslD/nvim-neoclip.lua", config = function() require('neoclip').setup() end, }
	-- use { '3lv/femboyf' }


	-- use { "blackCauldron7/surround.nvim", config = function() require"surround".setup {mappings_style = "sandwich"} end }
	-- use { 'abecodes/tabout.nvim', config=function() require('tabout').setup {} end }


	-->  THEMES AND UI
	use { 'folke/tokyonight.nvim' }
	use { 'tiagovla/tokyodark.nvim' }
	use { 'sainnhe/sonokai' }
	use { 'eddyekofo94/gruvbox-flat.nvim' }
	use { 'Pocco81/Catppuccino.nvim' }
	use { 'norcalli/nvim-colorizer.lua' , event='BufReadPre', config = function() require"plugins.plug-colorizer" end }
	use { 'folke/todo-comments.nvim' , event='BufReadPost' , config = function() require'todo-comments'.setup{} end }
	use { 'lewis6991/gitsigns.nvim' , config = function() require'gitsigns'.setup{} end , event='BufRead' }

	-->  LSP and COMPLETION
	use { 'neovim/nvim-lspconfig' }
	use { 'L3MON4D3/LuaSnip' , config = function() require"plugins.snippets" end }
	use { 'hrsh7th/nvim-cmp' , after="LuaSnip", config=function() require 'lsp.cmp' end }
	use { 'hrsh7th/cmp-buffer' }
	use { 'hrsh7th/cmp-nvim-lsp' }
	use { 'hrsh7th/cmp-path' }
	use { 'hrsh7th/cmp-emoji' }
	use { 'hrsh7th/cmp-nvim-lua' }
	-- use { 'saadparwaiz1/cmp_luasnip' }

	-->  TELESCOPE, TREESITTER, NEORG
	use { 'nvim-treesitter/nvim-treesitter' , event='BufRead', config=function() require"plugins.treesittter" end }
	use { 'nvim-treesitter/playground' , after="nvim-treesitter" }
	use { 'nvim-lua/plenary.nvim' }
	use { 'nvim-telescope/telescope.nvim' , config=function() require"plugins.telescope" end, cmd="Telescope"}
	use { 'nvim-neorg/neorg' , branch='unstable', event='BufReadPost', ft={"norg"}, after={"nvim-treesitter", "telescope.nvim"}, requires="vhyrro/neorg-telescope", config = function() require "plugins.neorg" end }

	-->  GENERAL PURPOSE
	use { 'lewis6991/impatient.nvim' }
	use { 'rcarriga/nvim-notify' }
	use { 'folke/lua-dev.nvim' }
	use { 'kyazdani42/nvim-web-devicons' , config = function() require "plugins.web_devicons" end }
	use { 'steelsojka/pears.nvim' , config=function() require"pears".setup() end}
	use { 'akinsho/nvim-toggleterm.lua' , event = "BufWinEnter", config = function() require"plugins.floaterm" end }
	use { 'iamcco/markdown-preview.nvim' , ft={'markdown'}, config = function() require"plugins.others".markdown_preview() end, run = "cd app && yarn install", }
	use { 'lukas-reineke/indent-blankline.nvim', event="BufReadPost", config = function() require"plugins.others".indent_blankline() end }


	use 'wbthomason/packer.nvim'
end }
