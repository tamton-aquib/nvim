require("lazy").setup({

    -->  Testing and temporary
    { 'Saecki/crates.nvim', event={'BufRead Cargo.toml'}, config=true },
    { 'simrat39/rust-tools.nvim', ft='rust', config=true },
    { 'antoinemadec/FixCursorHold.nvim' },
    { 'karb94/neoscroll.nvim', config=true, event='WinScrolled' },
    { 'danymat/neogen', config=true, cmd="Neogen" },

    -->  Might use in future
    -- use { 'ja-ford/delaytrain.nvim', config=_setup("delaytrain") }
    -- use { 'antonk52/bad-practices.nvim', config=_setup("bad_practices") }
    -- use { 'kwakzalver/duckytype.nvim', config=_setup("duckytype") }
    -- use { 'Maan2003/lsp_lines.nvim', config=_setup("lsp_lines"), event='DiagnosticChanged' }
    -- use { 'kylechui/nvim-surround', config=_setup("nvim-surround") }
    -- use { 'JASONews/glow-hover', config=_setup("glow-hover"), module="vim.lsp.buf" } -- TODO: pr for cmp docs too
    -- use { 'folke/zen-mode.nvim', config=_setup("zen-mode"), cmd="ZenMode" }
    -- use { 'folke/neodev.nvim', ft="lua" }

    -->  My Useless lil plugins
    -- { 'tamton-aquib/zone.nvim' }
    -- { 'tamton-aquib/keys.nvim', config=_setup("keys"), cmd="KeysToggle"}
    -- { 'tamton-aquib/duck.nvim' }
    { 'tamton-aquib/flirt.nvim', config=true },
    { 'tamton-aquib/stuff.nvim', lazy=true },
    { 'tamton-aquib/staline.nvim', config=function() require("_config").staline() end, event="ColorScheme" },
    { 'tamton-aquib/essentials.nvim', lazy=true },

    -->  THEMES AND UI
    { 'tiagovla/tokyodark.nvim' },
    { 'kyazdani42/nvim-web-devicons', config=function() require("_config").devicons() end, lazy=true },
    { 'norcalli/nvim-colorizer.lua', cmd="ColorizerToggle" },
    { 'lewis6991/gitsigns.nvim', config=true, event='BufReadPost' },
    { 'kyazdani42/nvim-tree.lua', config=function() require("_config").nvim_tree() end, cmd="NvimTreeToggle" },

    -->  LSP and COMPLETION
    { 'neovim/nvim-lspconfig' },
    { 'L3MON4D3/LuaSnip', config=function() require("_config").luasnip() end, event={"InsertEnter", "CmdlineEnter"} },
    { 'hrsh7th/nvim-cmp', config=function() require("_lsp").cmp() end },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-emoji' },
    { 'hrsh7th/cmp-nvim-lua' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'hrsh7th/cmp-nvim-lsp-signature-help' },
    { 'hrsh7th/cmp-cmdline' },

    -->  TELESCOPE, TREESITTER, NEORG
    { 'nvim-lua/plenary.nvim', lazy=true },
    { 'nvim-telescope/telescope.nvim', config=function() require("_config").telescope() end, cmd="Telescope" },
    { 'nvim-treesitter/nvim-treesitter', config=function() require("_config").treesitter() end, lazy=true }, --, event="BufRead" },
    -- 'nvim-treesitter/nvim-treesitter-textobjects',
    { 'nvim-neorg/neorg', ft="norg", config=function() require("_config").neorg() end },

    -->  GENERAL PURPOSE
    { 'ahmedkhalf/project.nvim', config=function() require("project_nvim").setup() end, lazy=true },
    { 'beauwilliams/focus.nvim', config=true, event="WinNew" },
    { 'windwp/nvim-autopairs', config=true, event="InsertEnter" },
    { 'lewis6991/impatient.nvim', },
    { 'samjwill/nvim-unception', },
    { 'toppair/peek.nvim', ft="markdown", build='deno task --quiet build:fast', config=true, lazy=true},
    { 'lukas-reineke/indent-blankline.nvim', config=function() require("_config").indent_blankline() end, event='BufReadPost'  },
})
-- 'iamcco/markdown-preview.nvim', ft={'markdown'}, config=conf("mkdp"), run = "cd app && npm install" }
