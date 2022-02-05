
require("packer").startup { function(use)

	-->  Testing and temporary
	use { 'tamton-aquib/staline.nvim', config=function() require"ui.staline" end }
	use { 'rktjmp/paperplanes.nvim', config=function() require("paperplanes").setup{} end, cmd="PP" }
	use { 'ahmedkhalf/project.nvim', config=function() require("project_nvim").setup{} end }

	use { 'themercorp/themer.lua' }
	-- use { 'nvim-plugnplay/plugnplay.nvim' }
	-- use { 'rlane/pounce.nvim' }
	-- use { 'tiagovla/tokyodark.nvim', event='BufEnter', config=function() vim.cmd [[colo tokyodark]] end }

	-->  Might use in future
	-- use { 'j-hui/fidget.nvim', config=function() require"fidget".setup { window={blend = 0} } end }
	-- use { 'danymat/neogen', config=function() require("neogen").setup{enable=true} end }
	-- use { 'rmagatti/goto-preview', config=function() require("plugins.others").goto_preview() end }
	-- use { 'wiliamks/nice-reference.nvim', config=[[require 'nice-reference'.setup({})]], cmd="NiceReference" }
	-- use { 'kevinhwang91/nvim-bqf' }
	-- use { 'nyngwang/NeoZoom.lua', cmd="NeoZoomToggle" }
	-- use { 'karb94/neoscroll.nvim' }
	-- use { 'elihunter173/dirbuf.nvim' }
	-- use { 'sunjon/stylish.nvim', config=function() vim.ui.menu = require('stylish').ui_menu() end }
	-- use { 'max397574/hangman.nvim', config=function() require("hangman").setup{} end, cmd="Hangman" }
	-- use { 'narutoxy/graphene.lua' }
	-- use { 'rlch/github-notifications.nvim' }
	-- use { 'chentau/marks.nvim', config=[[require("marks").setup{}]] }
	-- use { 'code-biscuits/nvim-biscuits', config=[[require("nvim-biscuits").setup{}]] }
	-- use { 'ggandor/lightspeed.nvim' }
	-- use { "max397574/startup.nvim", config=[[require"ui.startup-config"]] }
	-- use { "SmiteshP/nvim-gps", config=function() require("nvim-gps").setup() end, after={"nvim-treesitter"}}
	-- use { 'max397574/better-escape.nvim', config=function() require("better_escape").setup{mapping='jk'} end }
	-- use { 'simrat39/rust-tools.nvim', ft={'rust', 'rs'}, config=[[require("rust-tools").setup({})]] }
	-- use { 'abecodes/tabout.nvim', config=function() require('tabout').setup {} end }
	-- use { "blackCauldron7/surround.nvim", config = function() require"surround".setup {mappings_style = "sandwich"} end }
	-- use { 'edluffy/specs.nvim', config=function() require("plugins.others").specs() end }
	-- use { 'Pocco81/TrueZen.nvim' , config=function() require"true-zen".setup() end }

	-->  THEMES AND UI
	use { 'folke/todo-comments.nvim', event='BufReadPost' , config=function() require'todo-comments'.setup{} end }
	use { 'tamton-aquib/duck.nvim', config=function() require("duck").setup({winblend=0}) end }
	use { 'kyazdani42/nvim-web-devicons' }
	-- use { 'norcalli/nvim-colorizer.lua', event='BufReadPre', config=function() require"colorizer".setup() end }
	-- use { 'folke/tokyonight.nvim' }
	use { 'lewis6991/gitsigns.nvim', config=function() require'gitsigns'.setup{} end , event='BufRead' }

	-->  LSP and COMPLETION
	use { 'neovim/nvim-lspconfig' }
	use { 'L3MON4D3/LuaSnip' , config=function() require"plugins.snippets" end }
	use { 'hrsh7th/nvim-cmp' , after="LuaSnip", config=function() require 'lsp.cmp' end , disale=true}
	use { 'hrsh7th/cmp-buffer', after={"nvim-cmp"} }
	use { 'hrsh7th/cmp-nvim-lsp', after={"nvim-cmp"} }
	use { 'hrsh7th/cmp-path', after={"nvim-cmp"}  }
	use { 'hrsh7th/cmp-emoji', after={"nvim-cmp"}  }
	use { 'hrsh7th/cmp-nvim-lua', after={"nvim-cmp"}  }
	use { 'saadparwaiz1/cmp_luasnip', after={"nvim-cmp"}  }
	use { 'hrsh7th/cmp-nvim-lsp-signature-help', after={"nvim-cmp"}}
	use { 'williamboman/nvim-lsp-installer', config=function() require("lsp.lsp_installer") end }

	-->  TELESCOPE, TREESITTER, NEORG
	use { 'nvim-lua/plenary.nvim' }
	use { 'nvim-treesitter/playground' , cmd="TSHi" }
	use { 'nvim-telescope/telescope.nvim', cmd='Telescope' , config=function() require"plugins.telescope" end, module="telescope"}
	use { 'nvim-treesitter/nvim-treesitter', event='BufRead', config=function() require"plugins.treesittter" end }
	use { 'nvim-neorg/neorg', ft={"norg"}, after={"nvim-treesitter", "telescope.nvim"}, config = function() require "plugins.neorg" end }
	use { 'nvim-neorg/neorg-telescope' }

	-->  GENERAL PURPOSE
	use { 'folke/lua-dev.nvim' }
	use { 'nathom/filetype.nvim' }
	use { 'nanotee/luv-vimdocs' }
	use { 'rcarriga/nvim-notify', config=function() require("notify").setup {background_colour = "Visual"} end }
	use { 'tamton-aquib/essentials.nvim' }
	use { 'lewis6991/impatient.nvim' }
	use { 'beauwilliams/focus.nvim', config=function() require("focus").setup{cursorline=false} end, event="WinEnter" }
	use { 'steelsojka/pears.nvim', config=function() require"pears".setup() end}
	use { 'Saecki/crates.nvim', event={'BufRead Cargo.toml'}, config=function() require('crates').setup() end }
	use { 'kyazdani42/nvim-tree.lua', config=[[ require 'plugins.nvim_tree' ]], cmd='NvimTreeToggle'}
	use { 'akinsho/nvim-toggleterm.lua', event="BufWinEnter", config=function() require"plugins.floaterm" end }
	use { 'iamcco/markdown-preview.nvim', ft={'markdown'}, config=function() require"plugins.others".markdown_preview() end }
	use { 'lukas-reineke/indent-blankline.nvim', event="BufReadPost", config=function() require"plugins.others".indent_blankline() end }

	use 'wbthomason/packer.nvim'
end }
