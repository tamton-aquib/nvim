local packer = require("packer")
packer.init { profile = { enable = true } }
local _setup = function(name) return ("require('%s').setup()"):format(name) end
local conf = function(name) return ("require('_config').%s()"):format(name) end

packer.startup { function(use)

    -->  Testing and temporary
    use { 'sindrets/diffview.nvim', config=_setup("diffview"), cmd="DiffviewOpen" }
    use { 'samjwill/nvim-unception', event='TermEnter' }
    -- use { 'ahmedkhalf/project.nvim', config=_setup("project_nvim") }

    -->  Might use in future
    -- use { 'simrat39/rust-tools.nvim', ft='rust', config=_setup("rust-tools") }
    -- use { 'elihunter173/dirbuf.nvim' }
    -- use { 'kevinhwang91/nvim-bqf', config=_setup("bqf") }
    -- use { 'tamton-aquib/zone.nvim', config=function() require("zone").setup({after=100}) end }
    -- use { 'tamton-aquib/keys.nvim', config=function() require("keys").setup() end, cmd="KeysToggle"}


    -->  THEMES AND UI
    use { 'tiagovla/tokyodark.nvim' }
    use { 'kyazdani42/nvim-web-devicons' }
    use { 'norcalli/nvim-colorizer.lua', cmd="ColorizerToggle", config=_setup("colorizer") }
    use { 'lewis6991/gitsigns.nvim', config=_setup("gitsigns"), event='BufRead' }
    use { 'kyazdani42/nvim-tree.lua', config=conf('nvim_tree'), cmd='NvimTreeToggle'}
    use { 'tamton-aquib/staline.nvim', config=conf("staline"), branch='dev' }
    use { 'karb94/neoscroll.nvim', config=_setup("neoscroll"), event='WinScrolled' }

    -->  LSP and COMPLETION
    use { 'neovim/nvim-lspconfig' }
    use { 'L3MON4D3/LuaSnip', config=conf("luasnip"), event={"InsertEnter", "CmdlineEnter"} }
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
    use { 'nvim-treesitter/playground' , cmd="TSCaptureUnderCursor" }
    use { 'nvim-telescope/telescope.nvim', cmd='Telescope' , config=conf("telescope"), module="telescope"}
    use { 'nvim-treesitter/nvim-treesitter', event='BufRead', config=conf("treesitter") }
    use { 'nvim-neorg/neorg', ft={"norg"}, after={"nvim-treesitter", "telescope.nvim"}, config=conf("neorg") }
    use { 'danymat/neogen', config=_setup("neogen"), cmd="Neogen"}

    -->  GENERAL PURPOSE
    use { 'tamton-aquib/duck.nvim', config=_setup("duck") }
    use { 'folke/lua-dev.nvim', module="lua-dev"}
    use { 'beauwilliams/focus.nvim', config=_setup("focus"), event="WinNew" }
    use { 'windwp/nvim-autopairs', config=_setup("nvim-autopairs"), event='InsertEnter' }
    use { 'nanotee/luv-vimdocs', ft={"lua"} }
    use { 'rcarriga/nvim-notify', config=function() require("notify").setup{render='minimal'} end }
    use { 'lewis6991/impatient.nvim' }
    use { 'rktjmp/paperplanes.nvim', config=_setup("paperplanes"), cmd="PP" }
    use { 'Saecki/crates.nvim', event={'BufRead Cargo.toml'}, config=_setup('crates') }
    use { 'iamcco/markdown-preview.nvim', ft={'markdown'}, config=function() vim.g.mkdp_auto_close = 0 end }
    use { 'lukas-reineke/indent-blankline.nvim', event="BufReadPost", config=conf("indent_blankline") }
    use { 'tamton-aquib/essentials.nvim', branch='dev' }

    use { 'wbthomason/packer.nvim' }
end }
