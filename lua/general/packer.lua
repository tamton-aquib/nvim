
vim.cmd [[packadd packer.nvim]]
local packer = require 'packer'

packer.init {
	display = {
		done_sym = "✓",
		error_syn = "×",
	}
}

packer.startup { function(use)

	use 'tjdevries/astronauta.nvim'
	use {'tamton-aquib/staline.nvim', branch = 'beta'}
	-- use 'ghifarit53/tokyonight-vim'
	-- 'folke/tokyonight.nvim'
	use 'folke/zen-mode.nvim'
	-- use 'tiagovla/tokyodark.nvim'
	use {'vhyrro/neorg', branch =  'unstable'}

	--> Themes and looks
	use 'monsonjeremy/onedark.nvim'
	use 'sainnhe/sonokai'
	use 'eddyekofo94/gruvbox-flat.nvim'
	-- use 'mhinz/vim-startify'
	use 'glepnir/dashboard-nvim'
	use 'norcalli/nvim-colorizer.lua'
	use 'folke/todo-comments.nvim'
	--> LSP
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-compe'
	use 'onsails/lspkind-nvim'
	use 'kabouzeid/nvim-lspinstall'
	--> General Purpose
	use 'L3MON4D3/LuaSnip'
	use 'kyazdani42/nvim-web-devicons'
	use 'nvim-treesitter/nvim-treesitter'
	use 'nvim-treesitter/playground'
	use 'tamago324/lir.nvim'
	use 'steelsojka/pears.nvim'
	use 'akinsho/nvim-toggleterm.lua'
	--> Web dev Utils
	use {'iamcco/markdown-preview.nvim', ft={'markdown'}}
	--> Telescope
	use 'nvim-lua/popup.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'

	use 'wbthomason/packer.nvim'
end,
config = {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  }
}
}


