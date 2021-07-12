local packer = require 'packer'

packer.init {
	display = {
		done_sym = "✓",
		error_syn = "×",
	}
}

packer.startup { function(use)
	use '/home/taj/TOOLS/noiceboard'
	use '/home/taj/TOOLS/noice_dark'

	use 'ray-x/lsp_signature.nvim'

	use {'vhyrro/neorg', branch =  'unstable'}
	use 'ghifarit53/tokyonight-vim'
	use 'tamton-aquib/staline.nvim'

	--> Themes and UI
	use 'monsonjeremy/onedark.nvim'
	use 'sainnhe/sonokai'
	use 'tiagovla/tokyodark.nvim'
	use 'eddyekofo94/gruvbox-flat.nvim'
	use 'norcalli/nvim-colorizer.lua'
	use {'folke/todo-comments.nvim', config = function() require'todo-comments'.setup{} end}
	use 'lewis6991/gitsigns.nvim'
	use 'folke/zen-mode.nvim'

	--> LSP
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-compe'
	use 'kabouzeid/nvim-lspinstall'
	-- use {'onsails/lspkind-nvim', config = function() require'lspkind'.init{with_text=false} end}

	--> General Purpose
	use 'L3MON4D3/LuaSnip'
	use 'kyazdani42/nvim-web-devicons'
	use 'tamago324/lir.nvim'
	use 'steelsojka/pears.nvim'
	use 'akinsho/nvim-toggleterm.lua'
	use 'tjdevries/astronauta.nvim'

	--> Web dev Utils
	use {'iamcco/markdown-preview.nvim', ft={'markdown'}}

	--> Telescope and Treesitter
	use 'nvim-treesitter/nvim-treesitter'
	use 'nvim-treesitter/playground'
	use 'nvim-lua/popup.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'

	use 'wbthomason/packer.nvim'
end, config = {
		display = {
			open_fn = function()
				return require('packer.util').float{ border = 'single' }
			end
		}
	}
}


