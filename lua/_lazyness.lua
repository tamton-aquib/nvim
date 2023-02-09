local path = vim.fn.stdpath("config") .. "/plugins.json"
local c = require("_config")

local real_plugins = {
    -->  Temporary and testing
    -- { 'antoinemadec/FixCursorHold.nvim' },
    -- { 'stevearc/oil.nvim', config=true },
    -- { 'toppair/reach.nvim', config=true },

    -->  Might use in future
    -- { 'akinsho/flutter-tools.nvim', config=true },
    -- { 'ja-ford/delaytrain.nvim', config={delay_ms=1000, grace_period=5} },
    -- { 'simrat39/rust-tools.nvim', ft='rust', config=true },
    -- { 'Maan2003/lsp_lines.nvim', config=true, event='LspAttach' },
    -- { 'kylechui/nvim-surround', config=true }
    -- { 'JASONews/glow-hover', config=true } -- TODO: pr for cmp docs too
    -- { 'folke/neodev.nvim', ft="lua" }

    -->  My Useless lil plugins
    -- { 'tamton-aquib/keys.nvim', config=true, cmd="KeysToggle"},
    -- { 'tamton-aquib/duck.nvim' },
    -- { 'tamton-aquib/zone.nvim', config=true },
    { 'tamton-aquib/flirt.nvim', config=true },
    { 'tamton-aquib/stuff.nvim' },
    { "tamton-aquib/mpv.nvim", opts={setup_widgets=true, timer={throttle=100}}, lazy=true },
    { 'tamton-aquib/staline.nvim', config=c.staline, event="ColorScheme" },
    { 'tamton-aquib/essentials.nvim', lazy=true },

    -->  THEMES AND UI
    { 'tiagovla/tokyodark.nvim' },
    { 'nvim-tree/nvim-web-devicons', config=c.devicons, lazy=true },
    { 'norcalli/nvim-colorizer.lua', cmd="ColorizerToggle" },
    { 'lewis6991/gitsigns.nvim', config=true, event='BufReadPost' },
    { 'nvim-tree/nvim-tree.lua', config=c.nvim_tree, lazy=true },
    { 'declancm/cinnamon.nvim', config=true, keys={'<C-u>', '<C-d>'} },
    { 'Saecki/crates.nvim', event={'BufRead Cargo.toml'}, config=true },

    -->  LSP and COMPLETION
    { 'neovim/nvim-lspconfig' },
    { 'L3MON4D3/LuaSnip', config=c.luasnip, event="InsertEnter", lazy=true },
    { 'hrsh7th/nvim-cmp', config=function() require("_lsp").cmp() end, event={"InsertEnter", "CmdlineEnter"}, lazy=true,
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
    { 'nvim-treesitter/nvim-treesitter', config=c.treesitter, lazy=true },
    { 'nvim-neorg/neorg', ft="norg", config=c.neorg },
    -- { dir='~/STUFF/NEOVIM/neorg', ft="norg", config=c.neorg },
    -- { dir='~/STUFF/NEOVIM/neorg-jupyter' },

    -->  GENERAL PURPOSE
    { 'danymat/neogen', opts={snippet_engine="luasnip"}, cmd="Neogen" },
    { 'notjedi/nvim-rooter.lua', config=true },
    { 'beauwilliams/focus.nvim', opts={cursorline=false}, event="WinNew" },
    { 'windwp/nvim-autopairs', config=true, event="InsertEnter" },
    { 'lewis6991/impatient.nvim' },
    { 'toppair/peek.nvim', ft="markdown", build='deno task --quiet build:fast', config=true },
    { 'lukas-reineke/indent-blankline.nvim', opts={show_current_context=true, char='▏'}, event='BufReadPost'  },
}

local installer_plugins = vim.tbl_map(function(p)
    return {p.url:gsub("https://github.com/", ""), config=p.config}
end, vim.json.decode(table.concat(vim.fn.readfile(path))))

local bruh = vim.list_extend(real_plugins, installer_plugins)
require("lazy").setup(bruh, { performance = { rtp = { disabled_plugins = {
    "python3_provider", "node_provider", "2html_plugin", "getscript", "getscriptPlugin",
    "gzip", "matchit", "tar", "tarPlugin", "rrhelper", "spellfile_plugin", "vimball",
    "vimballPlugin", "zip", "zipPlugin", "tutor", "rplugin", "spellfile", "tarPlugin",
    "man", "logiPat", "netrwSettings", "netrwFileHandlers", "remote_plugins"
}}}})
