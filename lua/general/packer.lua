
require("packer").startup { function(use)

	-->  Testing and temporary
	-- use { 'TimUntersberger/neogit', config=[[ require("neogit").setup() ]] }
	-- use { 'hrsh7th/vim-eft' }
	use { 'MordechaiHadad/nvim-lspmanager', branch='dev', config=function() require("lsp.lsps") end }
	use { '~/TOOLS/STALINE/staline.nvim' , config = [[ require"ui.staline" ]]}
	use { 'Saecki/crates.nvim', ft={'toml'}, config=[[ require('crates').setup() ]] }
	use { 'ggandor/lightspeed.nvim' }
	use { 'beauwilliams/focus.nvim', config = function() require("focus").setup{cursorline=false} end }
	use { 'ThePrimeagen/vim-be-good' }
	use {
		'NarutoXY/themer.lua',
		branch='dev',
		config=function()
			require("themer").setup {
				colorscheme = "dark_cpt",
				transparent = true,
				styles = {
					functions = { italic=true },
					keywords = { italic=true }
				}
			}

			require("themer").load("dark_cpt")
		end
	}
	-- use { 'bfredl/nvim-luadev' }
	-- use { "AckslD/nvim-neoclip.lua", config = function() require('neoclip').setup() end, }
	-- use { 'phaazon/hop.nvim' }
	-- use { 'abecodes/tabout.nvim', config=function() require('tabout').setup {} end }
	-- use { 'luukvbaal/stabilize.nvim', config = function() require("stabilize").setup() end }
	-- use { "blackCauldron7/surround.nvim", config = function() require"surround".setup {mappings_style = "sandwich"} end }
	-- use { 'edluffy/specs.nvim', config=function() require("plugins.others").specs() end }
	-- use { 'Pocco81/TrueZen.nvim' , config=function() require"true-zen".setup() end }
	-- use { 'windwp/floatline.nvim', config=function() require("floatline").setup() end }
	-- use { 'hrsh7th/cmp-cmdline' }

	-->  THEMES AND UI
	use { 'folke/todo-comments.nvim' , event='BufReadPost' , config=[[ require'todo-comments'.setup{} ]] }
	use { 'folke/tokyonight.nvim' }
	use { 'tiagovla/tokyodark.nvim' }
	use { 'sainnhe/sonokai' }
	use { 'eddyekofo94/gruvbox-flat.nvim' }
	use { 'Pocco81/Catppuccino.nvim' }
	use { 'norcalli/nvim-colorizer.lua' , event='BufReadPre', config = [[ require"ui.plug-colorizer" ]] }
	use { 'lewis6991/gitsigns.nvim' , config = [[ require'gitsigns'.setup{} ]] , event='BufRead' }

	-->  LSP and COMPLETION
	use { 'neovim/nvim-lspconfig' }
	use { 'L3MON4D3/LuaSnip' , config = [[ require"plugins.snippets" ]] }
	use { 'hrsh7th/nvim-cmp' , after="LuaSnip", config=[[ require 'lsp.cmp' ]] }
	use { 'hrsh7th/cmp-buffer' }
	use { 'hrsh7th/cmp-nvim-lsp' }
	use { 'hrsh7th/cmp-path' }
	use { 'hrsh7th/cmp-emoji' }
	use { 'hrsh7th/cmp-nvim-lua' }
	use { 'saadparwaiz1/cmp_luasnip' }

	-->  TELESCOPE, TREESITTER, NEORG
	use { 'nvim-lua/plenary.nvim' }
	use { 'nvim-treesitter/playground' , after="nvim-treesitter" }
	use { 'nvim-telescope/telescope.nvim' , config=[[ require"plugins.telescope" ]], cmd="Telescope"}
	use { 'nvim-treesitter/nvim-treesitter' , event='BufRead', config=[[ require"plugins.treesittter" ]] }
	use { 'nvim-neorg/neorg' , branch='unstable', ft={"norg"}, after={"nvim-treesitter", "telescope.nvim"}, requires="nvim-neorg/neorg-telescope", config = function() require "plugins.neorg" end }

	-->  GENERAL PURPOSE
	use { 'folke/lua-dev.nvim' }
	use { 'nathom/filetype.nvim' }
	use { 'rcarriga/nvim-notify' }
	use { 'lewis6991/impatient.nvim', commit="561b86e5602def047010d451c3e7977a65982788" }
	use { 'tamton-aquib/essentials.nvim' }
	use { 'steelsojka/pears.nvim' , config=[[ require"pears".setup() ]]}
	use { 'kyazdani42/nvim-web-devicons' , config=[[ require "ui.web_devicons" ]] }
	-- use { 'max397574/better-escape.nvim', config=function() require("better_escape").setup{mapping='jk'} end }
	use { 'kyazdani42/nvim-tree.lua', config=[[ require 'plugins.nvim_tree' ]], cmd='NvimTreeToggle'}
	use { 'akinsho/nvim-toggleterm.lua' , event = "BufWinEnter", config=[[ require"plugins.floaterm" ]] }
	use { 'iamcco/markdown-preview.nvim' , ft={'markdown'}, config=[[ require"plugins.others".markdown_preview() ]], run = "cd app && yarn install", }
	use { 'lukas-reineke/indent-blankline.nvim', event="BufReadPost", config = [[ require"plugins.others".indent_blankline() ]] }

	use 'wbthomason/packer.nvim'
end }
