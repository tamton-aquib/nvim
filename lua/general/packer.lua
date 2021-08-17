local packer = require "packer"

packer.startup { function(use)
	--> Testing and temporary
    use {'rcarriga/nvim-notify'}

	-- use { 'tamton-aquib/staline.nvim', config = function() require"themes.staline" end }
    -- use { 'tamton-aquib/staline.nvim', config = function() require"staline".setup{} end }
    use { '~/TOOLS/staline.nvim',      config = function() require"themes.staline" end }
    -- use { '~/TOOLS/staline.nvim',      config = function() require"staline".setup{} end }


    --> THEMES AND UI
    use 'ghifarit53/tokyonight-vim'
    use 'sainnhe/sonokai'
    use 'eddyekofo94/gruvbox-flat.nvim'
    use 'norcalli/nvim-colorizer.lua'
    use { 'folke/todo-comments.nvim', config = function() require'todo-comments'.setup{} end }
    use { 'lewis6991/gitsigns.nvim', config = function() require'gitsigns'.setup{} end }


    --> LSP
    use 'neovim/nvim-lspconfig'
	use { 'hrsh7th/nvim-compe', after="LuaSnip", event = 'InsertEnter', config = function() require"lsp.compe-config" end }
	use 'kabouzeid/nvim-lspinstall'


	--> TELESCOPE, TREESITTER, NEORG
	use { 'nvim-treesitter/nvim-treesitter', event='BufRead', config = function() require"plugins.treesittter" end }
	use {'nvim-treesitter/playground', after="nvim-treesitter"}
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'
	use { 'vhyrro/neorg', branch='unstable', event = 'BufReadPost', ft = {"norg"}, after = "nvim-treesitter", requires = "vhyrro/neorg-telescope", config = function() require "plugins.neorg" end }



	--> GENERAL PURPOSE
	use { 'L3MON4D3/LuaSnip', config = function() require"plugins.snippets" end }
	use { 'kyazdani42/nvim-web-devicons', config = function() require "plugins.web_devicons" end }
	use { 'steelsojka/pears.nvim', config=function() require"plugins.pears" end}
	use { 'akinsho/nvim-toggleterm.lua', event = "BufWinEnter", config = function() require"plugins.floaterm" end }
	use 'tamago324/lir.nvim'
	use { 'iamcco/markdown-preview.nvim', ft={'markdown'},
		config = function()
			vim.g.mkdp_refresh_slow = 1
			vim.g.mkdp_auto_close = 0
		end,
		run = "cd app && yarn install", }

    use {'lukas-reineke/indent-blankline.nvim', event="BufReadPost",
		config = function()
			vim.g.indentLine_enabled = 1
			vim.g.indent_blankline_char = "▏"

			vim.g.indent_blankline_filetype_exclude = {"help", "terminal", "dashboard", "packer"}
			vim.g.indent_blankline_buftype_exclude = {"terminal"}
		end
    }

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
					border = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" }
					-- border = 'shadow'
				}
			end
		}
	}
}
