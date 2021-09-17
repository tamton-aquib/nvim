
require "packer".startup { function(use)

	--> Testing and temporary
	use { "karb94/neoscroll.nvim", event="WinScrolled", config=function() require"neoscroll".setup() end }
	use { '3lv/femboyf' }
	use { 'lewis6991/impatient.nvim' }
    use { 'tamton-aquib/staline.nvim' , config = function() require"themes.staline" end}

    --> THEMES AND UI
	use { 'folke/tokyonight.nvim' }
	use { 'tiagovla/tokyodark.nvim' }
    use { 'sainnhe/sonokai' }
    use { 'eddyekofo94/gruvbox-flat.nvim' }
	use { 'Pocco81/Catppuccino.nvim' }
	use { 'tamton-aquib/dynamic-cursor.nvim' , after="nvim-treesitter", config=function() require "dynamic-cursor".setup{} end }

    use { 'norcalli/nvim-colorizer.lua' , event='BufReadPre', config = function() require"plugins.plug-colorizer" end }
    use { 'folke/todo-comments.nvim' , config = function() require'todo-comments'.setup{} end }
    use { 'lewis6991/gitsigns.nvim' , config = function() require'gitsigns'.setup{} end }

    --> LSP and COMPLETION
    use { 'neovim/nvim-lspconfig' }
	-- use { 'kabouzeid/nvim-lspinstall' }
	use { 'MordechaiHadad/nvim-lspmanager', branch="dev" }
	use { 'L3MON4D3/LuaSnip' , config = function() require"plugins.snippets" end }
	use { 'hrsh7th/nvim-cmp' }
	use { 'hrsh7th/cmp-buffer' }
	use { 'hrsh7th/cmp-nvim-lsp' }
	use { 'hrsh7th/cmp-path' }
	use { 'hrsh7th/cmp-emoji' }
	use { 'hrsh7th/cmp-nvim-lua' }
	use { 'saadparwaiz1/cmp_luasnip' }

	--> TELESCOPE, TREESITTER, NEORG
	use { 'nvim-treesitter/nvim-treesitter' , event='BufRead', config=function() require"plugins.treesittter" end }
	use { 'nvim-treesitter/playground' , after="nvim-treesitter" }
	use { 'nvim-lua/plenary.nvim' }
	use { 'nvim-telescope/telescope.nvim' , config=function() require"plugins.telescope" end}
	use { 'nvim-neorg/neorg' , branch='unstable', event='BufReadPost', ft={"norg"}, after="nvim-treesitter", requires="vhyrro/neorg-telescope", config = function() require "plugins.neorg" end }

	--> GENERAL PURPOSE
    use { 'rcarriga/nvim-notify' }
	use { 'folke/lua-dev.nvim' }
	use { 'kyazdani42/nvim-web-devicons' , config = function() require "plugins.web_devicons" end }
	use { 'steelsojka/pears.nvim' , config=function() require"pears".setup() end}
	use { 'akinsho/nvim-toggleterm.lua' , event = "BufWinEnter", config = function() require"plugins.floaterm" end }
	use { 'tamago324/lir.nvim' , config = function() require"plugins.lir" end, after="nvim-web-devicons" }
	use { 'iamcco/markdown-preview.nvim' , ft={'markdown'}, config = function() require"plugins.others".markdown_preview() end, run = "cd app && yarn install", }
    use { 'lukas-reineke/indent-blankline.nvim', event="BufReadPost", config = function() require"plugins.others".indent_blankline() end }

	use 'wbthomason/packer.nvim'
end }
