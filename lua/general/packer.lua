local fn = vim.fn
local cmd = vim.api.nvim_command
local packer = require 'packer'


local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    cmd("!git clone https://github.com/wbthomason/packer.nvim " ..
                install_path)
    cmd "packadd packer.nvim"
end

packer.init {
	display = {
		done_sym = "✓",
		error_syn = "×",
	}
}

packer.startup { function(use)

	use 'glepnir/dashboard-nvim'
	use 'tamton-aquib/staline.nvim'
	-- use 'ghifarit53/tokyonight-vim'
	-- use 'folke/zen-mode.nvim'
	use 'tiagovla/tokyodark.nvim'
	use {'vhyrro/neorg', branch =  'unstable'}

	--> Themes and looks
	use 'monsonjeremy/onedark.nvim'
	use 'sainnhe/sonokai'
	use 'eddyekofo94/gruvbox-flat.nvim'
	-- use 'mhinz/vim-startify'
	use 'norcalli/nvim-colorizer.lua'
	use {'folke/todo-comments.nvim', config = function() require'todo-comments'.setup{} end}
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
	use {'steelsojka/pears.nvim', config = function() require "pears".setup() end}
	use 'akinsho/nvim-toggleterm.lua'
	--> Web dev Utils
	use {'iamcco/markdown-preview.nvim', ft={'markdown'}}
	--> Telescope
	use 'nvim-lua/popup.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'

	use 'wbthomason/packer.nvim'
end
}


