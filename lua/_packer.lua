local packer = require("packer")
packer.init { profile = { enable = true } }
local _setup = function(name) return ("require('%s').setup{}"):format(name) end
local conf = function(name) return ("require('_config').%s()"):format(name) end

packer.startup { function(use)

    -- themes: kat.nvim, shadotheme, articblush
    -->  Testing and temporary
    -- widget_guides={enabled=true}, closing_tags = {prefix="-> "}  for flutter tools
    -- use { 'akinsho/flutter-tools.nvim', config=function() require("flutter-tools").setup{} end}
    use { 'tiagovla/scope.nvim', config=_setup("scope") }
    use { 'Danielhp95/tmpclone-nvim', config=_setup("tmpclone"), cmd="TmpcloneClone" }
    use { 'ggandor/leap.nvim', config=function() require("leap").set_default_keymaps() end }
    use { 'kylechui/nvim-surround', config=_setup("nvim-surround") }
    use { 'samjwill/nvim-unception' }
    use { 'Maan2003/lsp_lines.nvim', config=_setup("lsp_lines"), event='DiagnosticChanged' }
    use { 'simrat39/rust-tools.nvim', ft='rust', config=_setup("rust-tools") }
    use { 'antoinemadec/FixCursorHold.nvim' }

    -->  Might use in future
    -- use { 'JASONews/glow-hover', config=_setup("glow-hover") } TODO: pr for cmp docs too
    -- use { 'antonk52/bad-practices.nvim', config=_setup("bad_practices") }
    -- use { 'folke/zen-mode.nvim', config=_setup("zen-mode"), cmd="TZAtaraxis" }
    -- use { 'elihunter173/dirbuf.nvim' }

    --> My Useless lil plugins
    -- use { 'tamton-aquib/zone.nvim', config=function() require("zone").setup({after=100}) end }
    -- use { 'tamton-aquib/keys.nvim', config=function() require("keys").setup() end, cmd="KeysToggle"}
    -- use { 'tamton-aquib/duck.nvim', config=_setup("duck"), module="duck" }
    -- use { 'tamton-aquib/stuff.nvim' }

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
