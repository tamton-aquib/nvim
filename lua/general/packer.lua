require 'packer'.startup { function(use)
	use '~/TOOLS/custom_plugins/noiceboard'
	-- use {'~/TOOLS/staline.nvim',
		-- config = function() require'themes.staline' end
		-- -- config = function()
			-- -- require'staline'.setup{}
			-- -- require'stabline'.setup{}
		-- -- end
	-- }
	use {'rcarriga/nvim-notify',} -- config = function() vim.notify = require("notify") end } }

	use {
		'tamton-aquib/staline.nvim', -- branch = 'beta',
		config = function() require'themes.staline' end
		-- config = function()
			-- require'staline'.setup{}
			-- require'stabline'.setup{}
		-- end
	}

	use 'vhyrro/neorg-telescope'

	--> Themes and UI
	use 'ghifarit53/tokyonight-vim'
	use 'monsonjeremy/onedark.nvim'
	use 'sainnhe/sonokai'
	use 'eddyekofo94/gruvbox-flat.nvim'
	use 'norcalli/nvim-colorizer.lua'
	use {
		'folke/todo-comments.nvim',
		config = function() require'todo-comments'.setup{} end
	}
	use {
		'lewis6991/gitsigns.nvim',
		config = function() require'gitsigns'.setup{} end
	}

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
	use {
		'kyazdani42/nvim-web-devicons',
		config = function() require'nvim-web-devicons'.setup{} end
	}
	use 'steelsojka/pears.nvim'
	use 'akinsho/nvim-toggleterm.lua'
	use 'kyazdani42/nvim-tree.lua'
	use {
		'iamcco/markdown-preview.nvim', ft={'markdown'},
		config = function()
			vim.g.mkdp_refresh_slow = 1
			vim.g.mkdp_auto_close = 0
		end,
		run = "cd app && yarn install",
	}
	use {'vhyrro/neorg', branch =  'unstable', after = "nvim-treesitter"}

	use 'wbthomason/packer.nvim'
end,

	config = {
		profile = {enable = true},
		done_sym = "✓",
		error_syn = "×",
		display = {
			open_fn = function()
				return require('packer.util').float{
					-- border = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" }
					border = 'shadow'
				}
			end
		}
	}
}

