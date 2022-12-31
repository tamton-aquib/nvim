local opts = { performance = { rtp = { disabled_plugins = {
    "python3_provider", "node_provider", "2html_plugin", "getscript", "getscriptPlugin",
    "gzip", "matchit", "tar", "tarPlugin", "rrhelper", "spellfile_plugin", "vimball",
    "vimballPlugin", "zip", "zipPlugin", "tutor", "rplugin", "spellfile", "tarPlugin",
    "man", "logiPat", "netrwSettings", "netrwFileHandlers", "remote_plugins"
}}}}

require("lazy").setup({

    -->  Testing and temporary
    { 'Saecki/crates.nvim', event={'BufRead Cargo.toml'}, config=true },
    { 'simrat39/rust-tools.nvim', ft='rust', config=true },
    { 'danymat/neogen', config=true, cmd="Neogen" },

    -->  Might use in future
    -- { 'antoinemadec/FixCursorHold.nvim' },
    -- { 'ja-ford/delaytrain.nvim', config=_setup("delaytrain") }
    -- { 'antonk52/bad-practices.nvim', config=_setup("bad_practices") }
    -- { 'kwakzalver/duckytype.nvim', config=_setup("duckytype") }
    -- { 'Maan2003/lsp_lines.nvim', config=_setup("lsp_lines"), event='DiagnosticChanged' }
    -- { 'kylechui/nvim-surround', config=_setup("nvim-surround") }
    -- { 'JASONews/glow-hover', config=_setup("glow-hover"), module="vim.lsp.buf" } -- TODO: pr for cmp docs too
    -- { 'folke/zen-mode.nvim', config=_setup("zen-mode"), cmd="ZenMode" }
    -- { 'folke/neodev.nvim', ft="lua" }

    -->  My Useless lil plugins
    -- { 'tamton-aquib/zone.nvim' }
    -- { 'tamton-aquib/keys.nvim', config=_setup("keys"), cmd="KeysToggle"}
    -- { 'tamton-aquib/duck.nvim' }
    { 'tamton-aquib/flirt.nvim', config=true, module=false },
    { 'tamton-aquib/stuff.nvim' },
    { "tamton-aquib/mpv.nvim", config={setup_widgets=true, timer={throttle=100}}, lazy=true },
    { 'tamton-aquib/staline.nvim', config=function() require("_config").staline() end, event="ColorScheme" },
    { 'tamton-aquib/essentials.nvim', lazy=true },

    -->  THEMES AND UI
    { 'tiagovla/tokyodark.nvim' },
    { 'kyazdani42/nvim-web-devicons', config=function() require("_config").devicons() end, lazy=true },
    { 'norcalli/nvim-colorizer.lua', cmd="ColorizerToggle" },
    { 'lewis6991/gitsigns.nvim', config=true, event='BufReadPost' },
    { 'kyazdani42/nvim-tree.lua', config=function() require("_config").nvim_tree() end },
    { 'declancm/cinnamon.nvim', config=true, keys={'<C-u>', '<C-d>'} },

    -->  LSP and COMPLETION
    { 'neovim/nvim-lspconfig' },
    { 'L3MON4D3/LuaSnip', config=function() require("_config").luasnip() end, event="VeryLazy" },
    { 'hrsh7th/nvim-cmp', config=function() require("_lsp").cmp() end, event="VeryLazy",
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-emoji',
            'hrsh7th/cmp-nvim-lua',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-cmdline'
        }
    },

    -->  TELESCOPE, TREESITTER, NEORG
    { 'nvim-lua/plenary.nvim', lazy=true },
    { 'nvim-telescope/telescope.nvim', config=function() require("_config").telescope() end, lazy=true },
    { 'nvim-treesitter/nvim-treesitter', config=function() require("_config").treesitter() end, lazy=true }, --, event="BufRead" },
    { 'nvim-neorg/neorg', ft="norg", config=function() require("_config").neorg() end },

    -->  GENERAL PURPOSE
    { 'notjedi/nvim-rooter.lua', config=true },
    { 'beauwilliams/focus.nvim', config=true, event="WinNew" },
    { 'windwp/nvim-autopairs', config=true, event="InsertEnter" },
    { 'lewis6991/impatient.nvim' },
    { 'toppair/peek.nvim', ft="markdown", build='deno task --quiet build:fast', config=true },
    { 'lukas-reineke/indent-blankline.nvim', config={show_current_context=true, char='▏'}, event='BufReadPost'  },
}, opts)
