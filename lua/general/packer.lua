require("packer").startup { function(use)

	-->  Testing and temporary
	use { 'ahmedkhalf/project.nvim', config=function() require("project_nvim").setup() end }
	-- use { 'toppair/reach.nvim', config=function() require("reach").setup() end }
	-- use { 'simrat39/rust-tools.nvim', ft='rust', config=function() require("rust-tools").setup() end }
	-- use { 'nvim-treesitter/nvim-treesitter-textobjects' }
	-- use { 'ZhiyuanLck/smart-pairs', event = 'InsertEnter', config = function() require('pairs'):setup() end }

	-->  Might use in future
	-- use { 'elihunter173/dirbuf.nvim' }
	-- use { 'nlsickler/colorscheme-tweaks.nvim' }
	-- use { 'edluffy/specs.nvim', config=function() require("specs").setup{} end }
	-- use { 'rmagatti/goto-preview', config=function() require("plugins").goto_preview() end }
	-- use { 'kevinhwang91/nvim-bqf', config=function() require("bqf").setup{} end}
	-- use { 'rlch/github-notifications.nvim' }
	-- use { 'ggandor/lightspeed.nvim' }
	-- use { 'abecodes/tabout.nvim', config=function() require('tabout').setup {} end }
	-- use { "blackCauldron7/surround.nvim", config = function() require"surround".setup {mappings_style = "sandwich"} end }

	-->  THEMES AND UI
	use { 'tiagovla/tokyodark.nvim' }
	use { 'tamton-aquib/duck.nvim', config=function() require("duck").setup({winblend=0}) end }
	use { 'kyazdani42/nvim-web-devicons' }
	use { 'norcalli/nvim-colorizer.lua', cmd="ColorizerToggle", config=function() require"colorizer".setup() end }
	use { 'lewis6991/gitsigns.nvim', config=function() require'gitsigns'.setup{} end , event='BufRead' }
	use { 'j-hui/fidget.nvim', config=function() require"fidget".setup { window={blend = 0} } end }
	use { 'tamton-aquib/staline.nvim', config=function() require("plugins").staline() end }
	use { 'hrsh7th/cmp-cmdline', event="CmdlineEnter"}
	use { 'kyazdani42/nvim-tree.lua', config=function() require('plugins').nvim_tree() end, cmd='NvimTreeToggle'}

	-->  LSP and COMPLETION
	use { 'neovim/nvim-lspconfig' }
	use { 'L3MON4D3/LuaSnip' , config=function() require("plugins").luasnip() end }
	use { 'hrsh7th/nvim-cmp' , after="LuaSnip", config=function() require('lsp.cmp') end }
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
	use { 'nvim-treesitter/playground' , cmd="TSHighlightCapturesUnderCursor" }
	use { 'nvim-telescope/telescope.nvim', cmd='Telescope' , config=function() require"plugins".telescope() end, module="telescope"}
	use { 'nvim-treesitter/nvim-treesitter', event='BufRead', config=function() require("plugins").treesitter() end }
	use { 'nvim-neorg/neorg', ft={"norg"}, after={"nvim-treesitter", "telescope.nvim"}, config = function() require("plugins").neorg() end }
	use { 'danymat/neogen', config=function() require("neogen").setup{} end }

	-->  GENERAL PURPOSE
	use { 'folke/lua-dev.nvim', module="lua-dev"}
	use { 'beauwilliams/focus.nvim', config=function() require("focus").setup{cursorline=false} end, event="WinNew" }
	use { 'nathom/filetype.nvim' }
	use { 'nanotee/luv-vimdocs' }
	use { 'tamton-aquib/essentials.nvim', branch='dev' }
	use { 'rcarriga/nvim-notify', config=function() require("notify").setup {background_colour = "Visual"} end }
	use { 'lewis6991/impatient.nvim' }
	use { 'rktjmp/paperplanes.nvim', config=function() require("paperplanes").setup{} end, cmd="PP" }
	use { 'Saecki/crates.nvim', event={'BufRead Cargo.toml'}, config=function() require('crates').setup() end }
	use { 'iamcco/markdown-preview.nvim', ft={'markdown'}, config=function() vim.g.mkdp_auto_close = 0 end }
	use { 'lukas-reineke/indent-blankline.nvim', event="BufReadPost", config=function() require("plugins").indent_blankline() end }

	use { 'wbthomason/packer.nvim' }
end }
