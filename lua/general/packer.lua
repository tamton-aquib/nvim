require 'packer'.startup { function(use)
	use '~/TOOLS/custom_plugins/noiceboard'

	use {'tamton-aquib/staline.nvim', branch='beta'}
	use 'vhyrro/neorg-telescope'

	--> Themes and UI
	use 'ghifarit53/tokyonight-vim'
	use 'monsonjeremy/onedark.nvim'
	use 'sainnhe/sonokai'
	use 'eddyekofo94/gruvbox-flat.nvim'
	use 'norcalli/nvim-colorizer.lua'
	use 'folke/todo-comments.nvim'
	use 'lewis6991/gitsigns.nvim'
	use 'folke/zen-mode.nvim'

	--> LSP
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/nvim-compe'
	use 'kabouzeid/nvim-lspinstall'

	--> Telescope and Treesitter
	use 'nvim-treesitter/nvim-treesitter'
	use 'nvim-treesitter/playground'
	use 'nvim-lua/popup.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'

	--> General Purpose
	use 'L3MON4D3/LuaSnip'
	use 'kyazdani42/nvim-web-devicons'
	use 'steelsojka/pears.nvim'
	use 'akinsho/nvim-toggleterm.lua'
	use 'kyazdani42/nvim-tree.lua'
	use {'iamcco/markdown-preview.nvim', ft={'markdown'}}
	use {'vhyrro/neorg', branch =  'unstable', after = "nvim-treesitter"}

	use 'wbthomason/packer.nvim'
end,

	config = {
		done_sym = "✓",
		error_syn = "×",
		display = {
			open_fn = function()
				return require('packer.util').float{
					border = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" }
				}
			end
		}
	}
}

