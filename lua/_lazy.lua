-- local _setup = function(name) return ("require('%s').setup{}"):format(name) end
-- local conf = function(name) return ("require('_config').%s()"):format(name) end

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
    { 'tamton-aquib/flirt.nvim', config=true },
    { 'tamton-aquib/stuff.nvim', },
    -- { 'tamton-aquib/duck.nvim' }
    -- { 'tamton-aquib/staline.nvim', config=function() require("_config").staline() end },
    { dir='~/STUFF/IDK/staline.nvim', config=function() require("_config").staline() end },
    { 'tamton-aquib/essentials.nvim' },

    -->  THEMES AND UI
    -- { 'tiagovla/tokyodark.nvim', config=function() require('tokyodark').colorscheme() end, lazy=false },
    { 'tiagovla/tokyodark.nvim', config=function() vim.cmd.colorscheme("tokyodark") end },
    { 'kyazdani42/nvim-web-devicons', config=function() require("_config").devicons() end },
    { 'norcalli/nvim-colorizer.lua', cmd="ColorizerToggle" },
    { 'lewis6991/gitsigns.nvim', config=true },
    { 'kyazdani42/nvim-tree.lua', config=function() require("_config").nvim_tree() end},

    -->  LSP and COMPLETION
    { 'neovim/nvim-lspconfig' },
    { 'L3MON4D3/LuaSnip', config=function() require("_config").luasnip() end, event={"InsertEnter", "CmdlineEnter"} },
    { 'hrsh7th/nvim-cmp', config=function() require("_lsp").cmp() end },
    { 'hrsh7th/cmp-buffer', },
    { 'hrsh7th/cmp-nvim-lsp', },
    { 'hrsh7th/cmp-path', },
    { 'hrsh7th/cmp-emoji', },
    { 'hrsh7th/cmp-nvim-lua', },
    { 'saadparwaiz1/cmp_luasnip', },
    { 'hrsh7th/cmp-nvim-lsp-signature-help', },
    { 'hrsh7th/cmp-cmdline', },

    -->  TELESCOPE, TREESITTER, NEORG
    -- { 'nvim-treesitter/playground' , cmd={"TSHi", "TSPlaygroundToggle"} }
    -- 'nvim-treesitter/playground',
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope.nvim', config=function() require("_config").telescope() end, cmd="Telescope" },
    { 'nvim-treesitter/nvim-treesitter', config=function() require("_config").treesitter() end }, --, event="BufRead" },
    -- 'nvim-treesitter/nvim-treesitter-textobjects', after="nvim-treesitter" }
    { 'tamton-aquib/neorg', ft="norg", branch="code-execution", config=function() require("_config").neorg() end },

    -->  GENERAL PURPOSE
    { 'ahmedkhalf/project.nvim', config=function() require("project_nvim").setup() end },
    { 'beauwilliams/focus.nvim', config=true },
    { 'windwp/nvim-autopairs', config=true, event="InsertEnter" },
    { 'lewis6991/impatient.nvim', },
    { 'samjwill/nvim-unception', },
    { 'iamcco/markdown-preview.nvim', ft='markdown', config=function() require("_config").mkdp() end, build = "cd app && npm install" },
    { 'lukas-reineke/indent-blankline.nvim', event="BufReadPost", config=function() require("_config").indent_blankline() end },
})
    -- 'iamcco/markdown-preview.nvim', ft={'markdown'}, config=conf("mkdp"), run = "cd app && npm install" }
