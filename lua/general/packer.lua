local packer = require 'packer'

packer.init {
	display = {
		done_sym = "✓",
		error_syn = "×",
	}
}

packer.startup { function(use)

-- 	use 'glepnir/dashboard-nvim'
	use 'lukas-reineke/indent-blankline.nvim'
-- 	use 'miffi/boot.nvim'
-- 	use 'tanvirtin/vgit.nvim'
	use 'tamton-aquib/staline.nvim'
	-- use 'ghifarit53/tokyonight-vim'
	-- use 'folke/zen-mode.nvim'
	-- use 'mhinz/vim-startify'

	--> Themes and looks
	use 'monsonjeremy/onedark.nvim'
	use 'sainnhe/sonokai'
	use 'tiagovla/tokyodark.nvim'
	use 'eddyekofo94/gruvbox-flat.nvim'
	use 'norcalli/nvim-colorizer.lua'
	use {'folke/todo-comments.nvim', config = function() require'todo-comments'.setup{} end}

	--> LSP
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-compe'
	use 'kabouzeid/nvim-lspinstall'
	use {'onsails/lspkind-nvim', config = function() require'lspkind'.init{with_text=false} end}

	--> General Purpose
	use 'L3MON4D3/LuaSnip'
	use 'kyazdani42/nvim-web-devicons'
	use 'nvim-treesitter/nvim-treesitter'
	use 'nvim-treesitter/playground'
	use 'tamago324/lir.nvim'
	use {'steelsojka/pears.nvim', config = function() require "pears".setup() end}
	use 'akinsho/nvim-toggleterm.lua'
	use {'vhyrro/neorg', branch =  'unstable'}

	--> Web dev Utils
	use {'iamcco/markdown-preview.nvim', ft={'markdown'}}

	--> Telescope
	use 'nvim-lua/popup.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'

	use 'wbthomason/packer.nvim'
end
}


