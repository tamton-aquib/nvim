local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd 'packadd packer.nvim'
end

require "packer".startup { function(use)

	--> Testing and temporary
	use { "karb94/neoscroll.nvim", event="WinScrolled", config=function() require"neoscroll".setup() end }
	use { 'lewis6991/impatient.nvim' }
	use { 'tamton-aquib/dynamic-cursor.nvim', config=function() require "dynamic-cursor".setup{} end }
    use { 'tamton-aquib/staline.nvim', config = function() require"themes.staline" end}


    --> THEMES AND UI
	use { 'folke/tokyonight.nvim' }
	use { 'tiagovla/tokyodark.nvim' }
    use { 'sainnhe/sonokai' }
    use { 'eddyekofo94/gruvbox-flat.nvim' }

    use { 'norcalli/nvim-colorizer.lua', event='BufReadPre', config = function() require"plugins.plug-colorizer" end }
    use { 'folke/todo-comments.nvim', config = function() require'todo-comments'.setup{} end }
    use { 'lewis6991/gitsigns.nvim', config = function() require'gitsigns'.setup{} end }


    --> LSP and COMPLETION
    use { 'neovim/nvim-lspconfig' }
	use { 'kabouzeid/nvim-lspinstall' }
	use { 'L3MON4D3/LuaSnip', config = function() require"plugins.snippets" end }
	use { 'hrsh7th/nvim-cmp' }
	use { 'hrsh7th/cmp-buffer' }
	use { 'hrsh7th/cmp-nvim-lsp' }
	use { 'hrsh7th/cmp-path' }
	use { 'hrsh7th/cmp-emoji' }
	use { 'hrsh7th/cmp-nvim-lua' }
	use { 'saadparwaiz1/cmp_luasnip' }


	--> TELESCOPE, TREESITTER, NEORG
	use { 'nvim-treesitter/nvim-treesitter', event='BufRead', config = function() require"plugins.treesittter" end }
	use { 'nvim-treesitter/playground', after="nvim-treesitter" }
	use { 'nvim-lua/plenary.nvim' }
	use { 'nvim-telescope/telescope.nvim', config = function() require"plugins.telescope" end}
	use { 'vhyrro/neorg', branch='unstable', event = 'BufReadPost', ft = {"norg"}, after = "nvim-treesitter", requires = "vhyrro/neorg-telescope", config = function() require "plugins.neorg" end }


	--> GENERAL PURPOSE
    use { 'rcarriga/nvim-notify' }
	use { 'lewis6991/cleanfold.nvim', config = function() require "cleanfold".setup{} end }
	use { 'folke/lua-dev.nvim' }
	use { 'kyazdani42/nvim-web-devicons', config = function() require "plugins.web_devicons" end }
	use { 'steelsojka/pears.nvim', config=function() require"pears".setup() end}
	use { 'akinsho/nvim-toggleterm.lua', event = "BufWinEnter", config = function() require"plugins.floaterm" end }
	use { 'tamago324/lir.nvim', config = function() require"plugins.lir" end }
	use { 'iamcco/markdown-preview.nvim', ft={'markdown'}, config = function() require"plugins.others".markdown_preview() end, run = "cd app && yarn install", }
    use {'lukas-reineke/indent-blankline.nvim', event="BufReadPost", config = function() require"plugins.others".indent_blankline() end }

	use 'wbthomason/packer.nvim'
end,

	config = {
		profile = {enable = true},
		display = {
			done_sym = "✓",
			error_sym = "×",
			working_sym = "",
			open_fn = function()
				return require('packer.util').float{
					border = require"general.utils".border
				}
			end
		}
	}
}
