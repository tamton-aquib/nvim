local packer = require("packer")
packer.init { profile = { enable = true } }
local _setup = function(name) return ("require('%s').setup{}"):format(name) end
local conf = function(name) return ("require('_config').%s()"):format(name) end

packer.startup { function(use)

    -->  Testing and temporary
    use { 'Shadorain/shadotheme' }
    -- use { 'katawful/kat.nvim' }
    use { 'tamton-aquib/stuff.nvim' }

    use { 'JASONews/glow-hover', config=_setup("glow-hover") }
    use { 'samjwill/nvim-unception' }

    -->  Might use in future
    -- use { 'sindrets/diffview.nvim', config=_setup("diffview"), cmd="DiffviewOpen" }
    -- use { 'jinh0/eyeliner.nvim', config=_setup("eyeliner") }
    -- use { 'folke/zen-mode.nvim', config=_setup("zen-mode"), cmd="TZAtaraxis" }
    -- use { 'Maan2003/lsp_lines.nvim', config=function() require("lsp_lines").register_lsp_virtual_lines() end }
    -- use { 'simrat39/rust-tools.nvim', ft='rust', config=_setup("rust-tools") }
    -- use { 'elihunter173/dirbuf.nvim' }
    -- use { 'tamton-aquib/zone.nvim', config=function() require("zone").setup({after=100}) end }
    -- use { 'tamton-aquib/keys.nvim', config=function() require("keys").setup() end, cmd="KeysToggle"}
    use { 'tamton-aquib/duck.nvim', config=_setup("duck"), module="duck" }

    -->  THEMES AND UI
    use { 'tiagovla/tokyodark.nvim' }
    use { 'kyazdani42/nvim-web-devicons', config=conf("devicons") }
    use { 'norcalli/nvim-colorizer.lua', cmd="ColorizerToggle", config=_setup("colorizer") }
    use { 'lewis6991/gitsigns.nvim', config=_setup("gitsigns"), event='BufRead' }
    use { 'kyazdani42/nvim-tree.lua', config=conf('nvim_tree'), cmd='NvimTreeToggle'}
    use { 'karb94/neoscroll.nvim', config=_setup("neoscroll"), event='WinScrolled' }
    use { 'tamton-aquib/staline.nvim', config=conf("staline") }

    -->  LSP
    use { 'neovim/nvim-lspconfig' }
    use { 'folke/trouble.nvim', config=_setup("trouble"), cmd="TroubleToggle" }
    use { 'folke/lua-dev.nvim', module="lua-dev"}

    -->  COMPLETION
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

    -->  TELESCOPE, TREESITTER, NEORG
    use { 'nvim-lua/plenary.nvim' }
    use { 'nvim-treesitter/playground' , cmd="TSHi" }
    use { 'nvim-telescope/telescope.nvim', cmd='Telescope' , config=conf("telescope"), module="telescope"}
    use { 'nvim-treesitter/nvim-treesitter', event='BufRead', config=conf("treesitter") }
    use { 'nvim-neorg/neorg', ft={"norg"}, after={"nvim-treesitter", "telescope.nvim"}, config=conf("neorg") }
    use { 'danymat/neogen', config=_setup("neogen"), cmd="Neogen"}

    -->  GENERAL PURPOSE
    use { 'ahmedkhalf/project.nvim', config=_setup("project_nvim") }
    use { 'beauwilliams/focus.nvim', config=_setup("focus"), event="WinNew" }
    use { 'windwp/nvim-autopairs', config=_setup("nvim-autopairs"), event='InsertEnter' }
    use { 'nanotee/luv-vimdocs', ft={"lua"} }
    use { 'rcarriga/nvim-notify', config=conf("notify")}
    use { 'lewis6991/impatient.nvim' }
    use { 'rktjmp/paperplanes.nvim', config=_setup("paperplanes"), cmd="PP" }
    use { 'Saecki/crates.nvim', event={'BufRead Cargo.toml'}, config=_setup('crates') }
    use { 'iamcco/markdown-preview.nvim', ft={'markdown'}, config=conf("mkdp") }
    use { 'lukas-reineke/indent-blankline.nvim', event="BufReadPost", config=conf("indent_blankline") }
    use { 'tamton-aquib/essentials.nvim' }

    use { 'wbthomason/packer.nvim' }
end }
