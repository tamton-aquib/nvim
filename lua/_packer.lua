local packer = require("packer")
local _setup = function(name) return ("require('%s').setup()"):format(name) end
local conf = function(name) return ("require('_config').%s()"):format(name) end

packer.startup { function(use)

    -->  Testing and temporary
    use { 'sindrets/diffview.nvim', config=_setup("diffview"), cmd="DiffviewOpen" }
    -- use { 'ahmedkhalf/project.nvim', config=_setup("project_nvim") }
    -- use { 'kevinhwang91/nvim-fFHighlight', config=_setup("fFHighlight"), keys='f' }
    -- use { 'kwakzalver/duckytype.nvim' }
    -- use { 'simrat39/rust-tools.nvim', ft='rust', config=function() require("rust-tools").setup() end }
    -- use { 'nvim-treesitter/nvim-treesitter-textobjects' }

    -->  Might use in future
    -- use { 'elihunter173/dirbuf.nvim' }
    -- use { 'nlsickler/colorscheme-tweaks.nvim' }
    -- use { 'rmagatti/goto-preview', config=function() require("_config").goto_preview() end }
    -- use { 'kevinhwang91/nvim-bqf', config=function() require("bqf").setup{} end}

    -->  THEMES AND UI
    use { 'tiagovla/tokyodark.nvim' }
    use { 'tamton-aquib/duck.nvim', config=_setup("duck") }
    use { 'kyazdani42/nvim-web-devicons' }
    use { 'norcalli/nvim-colorizer.lua', cmd="ColorizerToggle", config=_setup("colorizer") }
    use { 'lewis6991/gitsigns.nvim', config=_setup("gitsigns"), event='BufRead' }
    use { 'kyazdani42/nvim-tree.lua', config=conf('nvim_tree'), cmd='NvimTreeToggle'}
    use { 'tamton-aquib/staline.nvim', config=conf("staline") }
    use { 'karb94/neoscroll.nvim', config=_setup("neoscroll"), event='WinScrolled' }

    -->  LSP and COMPLETION
    use { 'neovim/nvim-lspconfig' }
    use { 'L3MON4D3/LuaSnip', config=conf("luasnip") , event="InsertEnter" }
    use { 'hrsh7th/nvim-cmp' , after="LuaSnip", config=function() require("_lsp").cmp() end }
    use { 'hrsh7th/cmp-buffer', after={"nvim-cmp"} }
    use { 'hrsh7th/cmp-nvim-lsp', after={"nvim-cmp"} }
    use { 'hrsh7th/cmp-path', after={"nvim-cmp"} }
    use { 'hrsh7th/cmp-emoji', after={"nvim-cmp"} }
    use { 'hrsh7th/cmp-nvim-lua', after={"nvim-cmp"} }
    use { 'saadparwaiz1/cmp_luasnip', after={"nvim-cmp"} }
    use { 'hrsh7th/cmp-nvim-lsp-signature-help', after={"nvim-cmp"}}
    use { 'hrsh7th/cmp-cmdline', event="CmdlineEnter", after={"nvim-cmp"}}
    use { 'williamboman/nvim-lsp-installer', config=function() require("_lsp").lsp_installer() end }

    -->  TELESCOPE, TREESITTER, NEORG
    use { 'nvim-lua/plenary.nvim' }
    use { 'nvim-treesitter/playground' , cmd="TSHighlightCapturesUnderCursor" }
    use { 'nvim-telescope/telescope.nvim', cmd='Telescope' , config=conf("telescope"), module="telescope"}
    use { 'nvim-treesitter/nvim-treesitter', event='BufRead', config=conf("treesitter") }
    use { 'nvim-neorg/neorg', ft={"norg"}, after={"nvim-treesitter", "telescope.nvim"}, config=conf("neorg") }
    use { 'danymat/neogen', config=_setup("neogen"), cmd="Neogen"}

    -->  GENERAL PURPOSE
    use { 'folke/lua-dev.nvim', module="lua-dev"}
    use { 'beauwilliams/focus.nvim', config=_setup("focus"), event="WinNew" }
    use { 'windwp/nvim-autopairs', config=_setup("nvim-autopairs"), event='InsertEnter' }
    use { 'nanotee/luv-vimdocs' }
    use { 'rcarriga/nvim-notify', config=function() require("notify").setup{render='minimal'} end }
    use { 'lewis6991/impatient.nvim' }
    use { 'rktjmp/paperplanes.nvim', config=_setup("paperplanes"), cmd="PP" }
    use { 'Saecki/crates.nvim', event={'BufRead Cargo.toml'}, config=_setup('crates') }
    use { 'iamcco/markdown-preview.nvim', ft={'markdown'}, config=function() vim.g.mkdp_auto_close = 0 end }
    use { 'lukas-reineke/indent-blankline.nvim', event="BufReadPost", config=conf("indent_blankline") }
    use { 'tamton-aquib/essentials.nvim' }

    use { 'wbthomason/packer.nvim' }
end }

