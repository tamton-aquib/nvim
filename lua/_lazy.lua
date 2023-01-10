local opts = { performance = { rtp = { disabled_plugins = {
    "python3_provider", "node_provider", "2html_plugin", "getscript", "getscriptPlugin",
    "gzip", "matchit", "tar", "tarPlugin", "rrhelper", "spellfile_plugin", "vimball",
    "vimballPlugin", "zip", "zipPlugin", "tutor", "rplugin", "spellfile", "tarPlugin",
    "man", "logiPat", "netrwSettings", "netrwFileHandlers", "remote_plugins"
}}}}
local c = require("_config")

require("lazy").setup({

    -->  Testing and temporary
    { 'Saecki/crates.nvim', event={'BufRead Cargo.toml'}, config=true },
    { 'danymat/neogen', config=true, cmd="Neogen" },

    -->  Might use in future
    -- { 'ja-ford/delaytrain.nvim', config={delay_ms=1000, grace_period=5} },
    -- { 'akinsho/flutter-tools.nvim', config=true },
    -- { 'sindrets/diffview.nvim' },
    -- { 'simrat39/rust-tools.nvim', ft='rust', config=true },
    -- { 'antoinemadec/FixCursorHold.nvim' },
    -- { 'antonk52/bad-practices.nvim', config=_setup("bad_practices") }
    -- { 'kwakzalver/duckytype.nvim', config=true },
    -- { 'Maan2003/lsp_lines.nvim', config=true, event='LspAttach' },
    -- { 'kylechui/nvim-surround', config=_setup("nvim-surround") }
    -- { 'JASONews/glow-hover', config=_setup("glow-hover"), module="vim.lsp.buf" } -- TODO: pr for cmp docs too
    -- { 'folke/zen-mode.nvim', config=_setup("zen-mode"), cmd="ZenMode" }
    -- { 'folke/neodev.nvim', ft="lua" }

    -->  My Useless lil plugins
    -- { 'tamton-aquib/zone.nvim' },
    -- { 'tamton-aquib/keys.nvim', config=true, cmd="KeysToggle"},
    -- { 'tamton-aquib/duck.nvim' },
    { 'tamton-aquib/flirt.nvim', config=true },
    { 'tamton-aquib/stuff.nvim' },
    { "tamton-aquib/mpv.nvim", config={setup_widgets=true, timer={throttle=100}}, lazy=true },
    { 'tamton-aquib/staline.nvim', config=c.staline, event="ColorScheme" },
    { 'tamton-aquib/essentials.nvim', lazy=true },

    -->  THEMES AND UI
    { 'tiagovla/tokyodark.nvim' },
    { 'kyazdani42/nvim-web-devicons', config=c.devicons, lazy=true },
    { 'norcalli/nvim-colorizer.lua', cmd="ColorizerToggle" },
    { 'lewis6991/gitsigns.nvim', config=true, event='BufReadPost' },
    { 'kyazdani42/nvim-tree.lua', config=c.nvim_tree },
    { 'declancm/cinnamon.nvim', config=true, keys={'<C-u>', '<C-d>'} },

    -->  LSP and COMPLETION
    { 'neovim/nvim-lspconfig' },
    { 'L3MON4D3/LuaSnip', config=c.luasnip, event="InsertEnter", lazy=true },
    { 'hrsh7th/nvim-cmp', config=function() require("_lsp").cmp() end, event={"InsertEnter", "CmdlineEnter", lazy=true},
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
    { 'nvim-telescope/telescope.nvim', config=c.telescope, lazy=true, cmd="Telescope" },
    -- { 'nvim-treesitter/nvim-treesitter', config=c.treesitter, lazy=true }, --, event="BufRead" },
    { 'nvim-treesitter/nvim-treesitter', config=c.treesitter, lazy=true },--  event="BufRead" },
    -- { 'nvim-treesitter/nvim-treesitter', config=c.treesitter }, --, event="BufRead" },
    -- { 'nvim-neorg/neorg', ft="norg", config=c.neorg },
    { 'nvim-neorg/neorg', ft="norg", config=c.neorg },

    -->  GENERAL PURPOSE
    { 'notjedi/nvim-rooter.lua', config=true },
    { 'beauwilliams/focus.nvim', config=true, event="WinNew" },
    { 'windwp/nvim-autopairs', config=true, event="InsertEnter" },
    { 'lewis6991/impatient.nvim' },
    { 'toppair/peek.nvim', ft="markdown", build='deno task --quiet build:fast', config=true },
    { 'lukas-reineke/indent-blankline.nvim', config={show_current_context=true, char='▏'}, event='BufReadPost'  },
}, opts)
