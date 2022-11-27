local packer = require("packer")
packer.init { profile = { enable = true } }
local _setup = function(name) return ("require('%s').setup{}"):format(name) end
local conf = function(name) return ("require('_config').%s()"):format(name) end

packer.startup { function(use)

    -- themes: kat.nvim, articblush, tundra, gruvbox-material, tokyodark
    -->  Testing and temporary
    -- use { 'articblush/nvim' }
    -- use { 'NarutoXY/graphene.lua', config=_setup("silicon") }
    -- use { 'jubnzv/mdeval.nvim' }
    -- use { 'gorbit99/codewindow.nvim', config=_setup("codewindow")}
    -- use { 'sainnhe/gruvbox-material' }
    -- use { 'akinsho/flutter-tools.nvim', ft='dart', config=_setup("flutter-tools")}
    use { 'Saecki/crates.nvim', event={'BufRead Cargo.toml'}, config=_setup('crates') }
    use { 'simrat39/rust-tools.nvim', ft='rust', config=_setup("rust-tools") }
    -- use { 'jinh0/eyeliner.nvim', config=_setup("eyeliner") }
    -- use { 'antoinemadec/FixCursorHold.nvim' }
    -- use { 'folke/trouble.nvim', config=_setup("trouble"), cmd="TroubleToggle" }

    -->  Might use in future
    -- use { 'ja-ford/delaytrain.nvim', config=_setup("delaytrain") }
    -- use { 'antonk52/bad-practices.nvim', config=_setup("bad_practices") }
    -- use { 'kwakzalver/duckytype.nvim', config=_setup("duckytype") }
    -- use { 'karb94/neoscroll.nvim', config=_setup("neoscroll"), event='WinScrolled' }
    -- use { 'tiagovla/scope.nvim', config=_setup("scope") }
    -- use { 'Maan2003/lsp_lines.nvim', config=_setup("lsp_lines"), event='DiagnosticChanged' }
    -- use { 'ggandor/leap.nvim', config=function() require("leap").set_default_keymaps() end }
    -- use { 'kylechui/nvim-surround', config=_setup("nvim-surround") }
    -- use { 'JASONews/glow-hover', config=_setup("glow-hover"), module="vim.lsp.buf" } -- TODO: pr for cmp docs too
    -- use { 'folke/zen-mode.nvim', config=_setup("zen-mode"), cmd="ZenMode" }
    -- use { 'folke/neodev.nvim', ft="lua" }
    -- use { 'danymat/neogen', config=_setup("neogen"), cmd="Neogen"}
    -- use { 'rktjmp/paperplanes.nvim', config=_setup("paperplanes"), cmd="PP" }

    -->  My Useless lil plugins
    -- use { 'tamton-aquib/zone.nvim' }
    -- use { 'tamton-aquib/keys.nvim', config=_setup("keys"), cmd="KeysToggle"}
    use { 'tamton-aquib/flirt.nvim', config=_setup("flirt") }
    use { 'tamton-aquib/stuff.nvim' }
    -- use { 'tamton-aquib/duck.nvim' }

    -->  THEMES AND UI
    use { 'tiagovla/tokyodark.nvim' }
    use { 'kyazdani42/nvim-web-devicons', config=conf("devicons") }
    use { 'norcalli/nvim-colorizer.lua', cmd="ColorizerToggle", config=_setup("colorizer") }
    use { 'lewis6991/gitsigns.nvim', config=_setup("gitsigns"), event='BufRead' }
    use { 'kyazdani42/nvim-tree.lua', config=conf('nvim_tree'), module='nvim-tree' }
    use { 'tamton-aquib/staline.nvim', config=conf("staline") }

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

    -->  TELESCOPE, TREESITTER, NEORG
    use { 'nvim-treesitter/playground' , cmd={"TSHi", "TSPlaygroundToggle"} }
    use { 'nvim-lua/plenary.nvim' }
    use { 'nvim-telescope/telescope.nvim', cmd='Telescope' , config=conf("telescope"), module="telescope"}
    use { 'nvim-treesitter/nvim-treesitter', event='BufRead', config=conf("treesitter") }
    use { 'nvim-treesitter/nvim-treesitter-textobjects', after="nvim-treesitter" }
    use { 'nvim-neorg/neorg', ft={"norg"}, after={"nvim-treesitter", "telescope.nvim"}, config=conf("neorg") }

    -->  GENERAL PURPOSE
    use { 'ahmedkhalf/project.nvim', config=_setup("project_nvim") }
    use { 'beauwilliams/focus.nvim', config=_setup("focus"), event="WinNew" }
    use { 'windwp/nvim-autopairs', config=_setup("nvim-autopairs"), event='InsertEnter' }
    -- use { 'rcarriga/nvim-notify', config=conf("notify")}
    use { 'rcarriga/nvim-notify', config=conf("notify") }
    use { 'lewis6991/impatient.nvim' }
    use { 'samjwill/nvim-unception' }
    use { 'iamcco/markdown-preview.nvim', ft={'markdown'}, config=conf("mkdp"), run = "cd app && npm install" }
    use { 'lukas-reineke/indent-blankline.nvim', event="BufReadPost", config=conf("indent_blankline") }
    use { 'tamton-aquib/essentials.nvim' }

    use { 'wbthomason/packer.nvim' }
end }
