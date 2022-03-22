require("packer").startup { function(use)

	-->  Testing and temporary
	use { 'ahmedkhalf/project.nvim', config=function() require("project_nvim").setup{} end }
	-- use { 'kyazdani42/nvim-tree.lua', config=[[ require 'plugins.nvim_tree' ]], cmd='NvimTreeToggle'}
	-- use { 'shift-d/scratch.nvim' }
	-- use { 'p00f/clangd_extensions.nvim' }
	-- use { 'dundargoc/stalker.nvim' }
	-- use { 'nlsickler/colorscheme-tweaks.nvim' }
	-- use { 'vim-scripts/vim-lamdify' }
	-- use { 'nvim-plugnplay/plugnplay.nvim' }
	-- use { 'ehamberg/vim-cute-python' }

	-->  Might use in future
	-- use { 'edluffy/specs.nvim', config=function() require("specs").setup{} end }
	-- use { 'rlane/pounce.nvim' }
	-- use { 'j-hui/fidget.nvim', config=function() require"fidget".setup { window={blend = 0} } end }
	-- use { 'rmagatti/goto-preview', config=function() require("plugins.others").goto_preview() end }
	-- use { 'wiliamks/nice-reference.nvim', config=[[require 'nice-reference'.setup({})]], cmd="NiceReference" }
	-- use { 'kevinhwang91/nvim-bqf', config=function() require("bqf").setup{} end}
	-- use { 'nyngwang/NeoZoom.lua', cmd="NeoZoomToggle" }
	-- use { 'karb94/neoscroll.nvim' }
	-- use { 'elihunter173/dirbuf.nvim' }
	-- use { 'sunjon/stylish.nvim', config=function() vim.ui.menu = require('stylish').ui_menu() end }
	-- use { 'rlch/github-notifications.nvim' }
	-- use { 'code-biscuits/nvim-biscuits', config=[[require("nvim-biscuits").setup{}]] }
	-- use { 'ggandor/lightspeed.nvim' }
	-- use { 'simrat39/rust-tools.nvim', ft={'rust', 'rs'}, config=[[require("rust-tools").setup({})]] }
	-- use { 'abecodes/tabout.nvim', config=function() require('tabout').setup {} end }
	-- use { "blackCauldron7/surround.nvim", config = function() require"surround".setup {mappings_style = "sandwich"} end }

	-->  THEMES AND UI
	use { 'themercorp/themer.lua' }
	use { 'tamton-aquib/duck.nvim', config=function() require("duck").setup({winblend=0}) end }
	use { 'kyazdani42/nvim-web-devicons' }
	use { 'norcalli/nvim-colorizer.lua', cmd="ColorizerToggle", config=function() require"colorizer".setup() end }
	use { 'lewis6991/gitsigns.nvim', config=function() require'gitsigns'.setup{} end , event='BufRead' }
	use { 'tamton-aquib/staline.nvim', config=function() require"ui.staline" end }

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
	use { 'danymat/neogen', config=function() require("neogen").setup{enable=true} end }

	-->  GENERAL PURPOSE
	use { 'folke/lua-dev.nvim' }
	use { 'beauwilliams/focus.nvim', config=function() require("focus").setup{cursorline=false} end, event="WinNew" }
	use { 'ZhiyuanLck/smart-pairs', event = 'InsertEnter', config = function() require('pairs'):setup() end }
	use { 'nathom/filetype.nvim' }
	use { 'nanotee/luv-vimdocs' }
	use { 'tamton-aquib/essentials.nvim', branch='dev' }
	use { 'rcarriga/nvim-notify', config=function() require("notify").setup {background_colour = "Visual"} end }
	use { 'lewis6991/impatient.nvim' }
	use { 'rktjmp/paperplanes.nvim', config=function() require("paperplanes").setup{} end, cmd="PP" }
	use { 'Saecki/crates.nvim', event={'BufRead Cargo.toml'}, config=function() require('crates').setup() end }
	use { 'iamcco/markdown-preview.nvim', ft={'markdown'}, config=function() require"plugins.others".markdown_preview() end }
	use { 'lukas-reineke/indent-blankline.nvim', event="BufReadPost", config=function() require"plugins.others".indent_blankline() end }

	use 'wbthomason/packer.nvim'
end }
