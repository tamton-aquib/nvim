
require("packer").startup { function(use)

	-->  Testing and temporary
	use { 'tamton-aquib/duck.nvim' }
	use { 'tamton-aquib/staline.nvim', config=[[require"ui.staline"]]}
	use { 'williamboman/nvim-lsp-installer', config=[[require("lsp.lsp_defaults")]] }
	-- use { 'chentau/marks.nvim', config=[[require("marks").setup{}]] }
	use { 'wiliamks/nice-reference.nvim', config=[[require 'nice-reference'.setup({})]] }

	-- use { 'NarutoXY/themer.lua', branch='dev', config=[[ require("ui.themer") ]] }
	-- use { 'code-biscuits/nvim-biscuits', config=[[require("nvim-biscuits").setup{}]] }
	-- use { 'ggandor/lightspeed.nvim' }
	-- use { "max397574/startup.nvim", config=[[require"ui.startup-config"]] }
	-- use { 'joshdick/onedark.vim' }
	-- use { 'hrsh7th/cmp-nvim-lsp-signature-help', after={"nvim-cmp"}}
	-- use { "SmiteshP/nvim-gps", config=function() require("nvim-gps").setup() end, after={"nvim-treesitter"}}
	-- use { 'max397574/better-escape.nvim', config=function() require("better_escape").setup{mapping='jk'} end }
	-- use { 'simrat39/rust-tools.nvim', ft={'rust', 'rs'}, config=[[require("rust-tools").setup({})]] }
	-- use { 'abecodes/tabout.nvim', config=function() require('tabout').setup {} end }
	-- use { "blackCauldron7/surround.nvim", config = function() require"surround".setup {mappings_style = "sandwich"} end }
	-- use { 'edluffy/specs.nvim', config=function() require("plugins.others").specs() end }
	-- use { 'Pocco81/TrueZen.nvim' , config=function() require"true-zen".setup() end }

	-->  THEMES AND UI
	use { 'folke/todo-comments.nvim', event='BufReadPost' , config=[[ require'todo-comments'.setup{} ]] }
	use { 'folke/tokyonight.nvim' }
	use { 'sainnhe/sonokai' }
	use { 'tiagovla/tokyodark.nvim' }
	use { 'sainnhe/gruvbox-material' }
	use { 'kyazdani42/nvim-web-devicons' , config=[[ require "nvim-web-devicons".setup{} ]] }
	use { 'norcalli/nvim-colorizer.lua' , event='BufReadPre', config = [[ require"colorizer".setup() ]] }
	use { 'lewis6991/gitsigns.nvim' , config = [[ require'gitsigns'.setup{} ]] , event='BufRead' }

	-->  LSP and COMPLETION
	use { 'neovim/nvim-lspconfig' }
	use { 'L3MON4D3/LuaSnip' , config = [[ require"plugins.snippets" ]] }
	use { 'hrsh7th/nvim-cmp' , after="LuaSnip", config=[[ require 'lsp.cmp' ]] , disale=true}
	use { 'hrsh7th/cmp-buffer', after={"nvim-cmp"} }
	use { 'hrsh7th/cmp-nvim-lsp', after={"nvim-cmp"} }
	use { 'hrsh7th/cmp-path', after={"nvim-cmp"}  }
	use { 'hrsh7th/cmp-emoji', after={"nvim-cmp"}  }
	use { 'hrsh7th/cmp-nvim-lua', after={"nvim-cmp"}  }
	use { 'saadparwaiz1/cmp_luasnip', after={"nvim-cmp"}  }

	-->  TELESCOPE, TREESITTER, NEORG
	use { 'nvim-lua/plenary.nvim' }
	use { 'nvim-treesitter/playground' , after="nvim-treesitter" }
	use { 'nvim-telescope/telescope.nvim', cmd='Telescope' , config=[[ require"plugins.telescope" ]], module="telescope"}
	use { 'nvim-treesitter/nvim-treesitter' , event='BufRead', config=[[ require"plugins.treesittter" ]] }
	use { 'nvim-neorg/neorg', ft={"norg"}, after={"nvim-treesitter", "telescope.nvim"}, config = function() require "plugins.neorg" end }
	use { 'nvim-neorg/neorg-telescope' }

	-->  GENERAL PURPOSE
	use { 'folke/lua-dev.nvim' }
	use { 'nathom/filetype.nvim' }
	use { 'rcarriga/nvim-notify' }
	use { 'tamton-aquib/essentials.nvim' }
	use { 'lewis6991/impatient.nvim' }
	use { 'beauwilliams/focus.nvim', config = [[require("focus").setup{cursorline=false}]] }
	use { 'steelsojka/pears.nvim', config=[[ require"pears".setup() ]]}
	use { 'Saecki/crates.nvim', event={'BufRead Cargo.toml'}, config=[[ require('crates').setup() ]] }
	use { 'kyazdani42/nvim-tree.lua', config=[[ require 'plugins.nvim_tree' ]], cmd='NvimTreeToggle'}
	use { 'akinsho/nvim-toggleterm.lua' , event = "BufWinEnter", config=[[ require"plugins.floaterm" ]] }
	use { 'iamcco/markdown-preview.nvim' , ft={'markdown'}, config=[[ require"plugins.others".markdown_preview() ]], run = "cd app && yarn install", }
	use { 'lukas-reineke/indent-blankline.nvim', event="BufReadPost", config = [[ require"plugins.others".indent_blankline() ]] }

	use 'wbthomason/packer.nvim'
end }
