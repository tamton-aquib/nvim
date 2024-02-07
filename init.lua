

-- {{{ -- Settings

vim.loader.enable()
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    print("Installing lazy.nvim...")
    vim.fn.system({"git", "clone", "--branch=stable", "--filter=blob:none", "https://github.com/folke/lazy.nvim", lazypath})
end

vim.opt.rtp:append(lazypath)
package.path = package.path .. ";"..vim.env.HOME.."/.luarocks/share/lua/5.1/?.lua;"..vim.env.HOME.."/.luarocks/share/lua/5.1/?/init.lua"
package.cpath = package.cpath .. ";" .. vim.env.HOME .. "/.luarocks/lib/lua/5.1/?.so"

local opts = {
    General = {
        exrc = true, spell = false, wrap = false, linebreak = true, ruler = false, conceallevel = 2,
        hlsearch = false, timeoutlen = 300, updatetime = 500, swapfile = false,
        wildignore = { '*.pyc,__pycache__,node_modules,*.lock,package%-lock%.json,target' }, cmdheight=1
    },
    Backup = { backup = false, writebackup = false },
    Layout = {
        scrolloff = 5, splitright = true, splitbelow = true, pumheight = 10,
        incsearch = true, showmode = false, showtabline = 2, laststatus = 3,
    },
    Edit = {
        completeopt = "menu,menuone,noselect", virtualedit = "block", ignorecase = true,
        clipboard = "unnamedplus", iskeyword = vim.o.iskeyword..",-"
    },
    Fold = {
        foldmethod = "expr",
        foldlevelstart = 99,
        foldexpr = 'v:lua.vim.treesitter.foldexpr()',
        foldtext = 'v:lua.require("essentials").simple_fold()'
    },
    Ui = {
        pumblend = 20, inccommand = "split", termguicolors = true, number = true, signcolumn = "yes:2",
        rnu = true, guifont = "JetBrainsMono Nerd Font:h11", shortmess = "tF".."TIcC".."as".."WoO",
        fillchars = { eob=' ', fold=' ', foldopen="", foldsep=" ", foldclose="" }
    },
    Tabspace = {
        shiftwidth = 4, tabstop = 4, softtabstop = 0, expandtab = true,
        smartindent = true, breakindent = true, smarttab = true
    }
}

for _, section in pairs(opts) do for k,v in pairs(section) do vim.opt[k] = v end end
-- vim.opt.statuscolumn = "%s %{foldlevel(v:lnum) <= foldlevel(v:lnum-1) ? ' ' : (foldclosed(v:lnum) == -1 ? '' : '')} %{v:relnum ? v:relnum : v:lnum} "

vim.schedule(function()
    local ess_status, essentials = pcall(require, "essentials")
    if ess_status then
        vim.ui.input = essentials.ui_input
        -- vim.ui.select = essentials.ui_select
        vim.notify = essentials.ui_notify
    end
end)

-- }}}

-- {{{ -- Utils
local Util = {}

Util.center = function(dict)
    local new_dict = {}
    for _, v in pairs(dict) do
        local padding = vim.fn.max(vim.fn.map(dict, 'strwidth(v:val)'))
        local spacing = (" "):rep(math.floor((vim.o.columns - padding) / 2)) .. v
        table.insert(new_dict, spacing)
    end
    return new_dict
end

--> Simple dashboard
Util.splash_screen = vim.schedule_wrap(function()
    local xdg = vim.fn.fnamemodify(vim.fn.stdpath("config") --[[@as string]], ":h").."/"
    local header = {
        "","", "", "", "", "",
        [[ ███▄    █     ▒█████      ██▓    ▄████▄     ▓█████   ]],
        [[ ██ ▀█   █    ▒██▒  ██▒   ▓██▒   ▒██▀ ▀█     ▓█   ▀   ]],
        [[▓██  ▀█ ██▒   ▒██░  ██▒   ▒██▒   ▒▓█    ▄    ▒███     ]],
        [[▓██▒  ▐▌██▒   ▒██   ██░   ░██░   ▒▓▓▄ ▄██▒   ▒▓█  ▄   ]],
        [[▒██░   ▓██░   ░ ████▓▒░   ░██░   ▒ ▓███▀ ░   ░▒████▒  ]],
        [[░ ▒░   ▒ ▒    ░ ▒░▒░▒░    ░▓     ░ ░▒ ▒  ░   ░░ ▒░ ░  ]],
        [[░ ░░   ░ ▒░     ░ ▒ ▒░     ▒ ░     ░  ▒       ░ ░  ░  ]],
        [[   ░   ░ ░    ░ ░ ░ ▒      ▒ ░   ░              ░     ]],
        [[         ░        ░ ░      ░     ░ ░            ░  ░  ]],
        [[                                 ░                    ]]
    }
    local arg = vim.fn.argv(0)
    if arg and (vim.fn.isdirectory(arg) ~= 0) or arg == "" and vim.bo.ft ~= "lazy" then

        vim.fn.matchadd("Error", '[░▒]')
        vim.fn.matchadd("Function", '[▓█▄▀▐▌]')
        local map = function(lhs, rhs) vim.keymap.set('n', lhs, rhs, {silent=true, buffer=0}) end
        local keys = {K='kitty/kitty.conf', W='wezterm/wezterm.lua', I='nvim/init.lua', A='alacritty/alacritty.yml', F='fish/config.fish'}
        vim.api.nvim_put(Util.center(header), "l", true, true)
        vim.cmd [[silent! setl nonu nornu nobl acd ft=dashboard bh=wipe bt=nofile]]

        for k,f in pairs(keys) do map(k,'<cmd>e '..xdg..f..' | setl noacd<CR>') end
        map('P', '<cmd>Telescope oldfiles<CR>'); map('q', '<cmd>q<CR>'); map('o', '<cmd>e #<1<CR>') -- edit the last edited file
    end
end)

--> Closing Windows and buffers
Util.close_command = function()
    if vim.bo.modified then print("buf not saved!") return end
    local total = #vim.tbl_filter(function(buf)
        return vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_name(buf) ~= ""
    end, vim.api.nvim_list_bufs())

    local quit_cmd = #vim.api.nvim_list_wins() > 1 and 'Q' or 'q'
    vim.cmd(total == 1  and quit_cmd or 'bd')
end

--> Different kinds of Borders
Util.border = ({
    { "╒", "═", "╕", "│", "╛", "═", "╘", "│" },
    { "▁", "▁", "▁", "▕", "▔", "▔", "▔", "▏" },
    { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" },
    { "", "", "", " ", "", "", "", " " }
})[2]
-- }}}

-- {{{ -- Autocmds

--> Wrapper function
local au = function(events, ptn, cb) vim.api.nvim_create_autocmd(events, {pattern=ptn, [type(cb)=="function" and 'callback' or 'command']=cb}) end

-->  LSP Related
au("BufWritePre", "*.rs,*.svelte", function() vim.lsp.buf.format() end)
au("CursorHold", "*", vim.diagnostic.open_float)
au("FileType", "json,http,markdown", "set cole=0")

-->  OLD
au("BufReadPost", "*.lua", [[call matchadd("Keyword", "--> \\zs󰈻.*\\ze$")]])
au("BufEnter", "*", 'setl fo-=cro')
au("BufReadPost", "*", function() require("essentials").last_place() end)
au("TextYankPost", "*", function() vim.highlight.on_yank({higroup="Visual", timeout=200}) end)
au("TermOpen", "term://*", "setl nonu nornu | star")
au("UIEnter", "*", Util.splash_screen)

-->  Commands
vim.api.nvim_create_user_command("Format", vim.lsp.buf.format, {})
vim.api.nvim_create_user_command("X", ":silent !xset r rate 169 69", {})
vim.api.nvim_create_user_command("PP", function() require("essentials").null_pointer() end, {range='%'})
vim.api.nvim_create_user_command("Mess", function() require("essentials").messages() end, {})
-- }}}

-- {{{ -- Mappings

vim.g.mapleader = " "
vim.g.maplocalleader = ","
---> Helper functions
local function map(mode, key, func) vim.keymap.set(mode, key, func, {silent=true}) end
local function cmd(s) return "<CMD>"..s.."<CR>" end

--> Harpoon
map('n', '<leader>u', function() require("thunder").run() end)
map('n', '<leader>k', function() require("essentials").konsole() end)
map('n', 'gQ', function() require("essentials").open_quick_note() end)
map('n', '<leader>ii', function() require("nvim-market").install_picker() end)
map('n', '<leader>iu', function() require("nvim-market").remove_picker() end)

map('n', '<Esc>', '<CMD>echo<CR>')
map('c', 'jk', '<C-f><cmd>resize -20<cr>')
map('n', '<leader>gn', cmd "Gitsigns next_hunk")
map('n', '<leader>gp', cmd "Gitsigns prev_hunk")
map('n', '<leader>gb', cmd "Gitsigns blame_line")
map('n', '<leader>gd', cmd "Gitsigns preview_hunk_inline")
map('n', '<leader>gr', cmd "Gitsigns reset_hunk")

map('n', '<C-n>', cmd "cnext")
map('n', '<C-p>', cmd "cprev")

--> TEMP and TEST maps
map('n', '<leader>l', function() require("essentials").toggle_term("lazygit", 't', true) end)
map({'n', 't'}, '<leader>t', function() require("essentials").toggle_term("fish", 'v', true) end)
map('n', '<leader>p', cmd 'Lazy')
map('t', '<Esc><Esc>', [[<C-\><C-n>]])
map('n', 'gh', function() vim.cmd.help(vim.fn.expand('<cword>')) end)

--> General Mappings
map('n', '<leader>e'   , function() require("nvim-tree.api").tree.toggle({find_file=true}) end)
map('n', '<leader>n'   , cmd 'Neogen')
map('n', '<leader>q'   , function() require("essentials").toggle_quickfix() end)
map('n', '<leader>z'   , cmd 'FocusMaximise')

--> stuff.nvim maps (https://github.com/tamton-aquib/stuff.nvim)
map('n', '<leader>cc', function() require("chatgpt").chatgpt() end)
map('n', 'gC', function() require("calc").toggle() end)
map('n', 'gS', function() require("stalk").stalk() end)
map('n', 'gs', function() require("scratch").toggle() end)
map('n', 'gB', function() require("bt").toggle() end)
map('n', 'gT', function() require("tmpclone").clone() end)
map('n', 'gp', function() require("mpv").toggle_player() end)
map('n', 'gP', function() require("dep").check() end)

--> Lsp mappings
map('n', 'gD',    vim.lsp.buf.definition)
map('n', 'gd',    '<cmd>vs | lua vim.lsp.buf.definition()<CR>')
map('n', 'gr',    vim.lsp.buf.references)
map('n', '<M-n>', vim.diagnostic.goto_next)
map('n', '<M-p>', vim.diagnostic.goto_prev)
map('n', '<leader>ca', vim.lsp.buf.code_action)

--> essentials.nvim mappings ( https://github.com/tamton-aquib/essentials.nvim )
map('v', '<leader>/' , ':lua require("essentials").toggle_comment(true)<CR>')
map('n', '<leader>/' , ':lua require("essentials").toggle_comment()<CR>')
map('n', '<F2>'      , function() require("essentials").rename() end)
map('n', '<leader>r' , function() require("essentials").run_file() end)
map('n', '<leader>s' , function() require("essentials").swap_bool() end)
map('n', '<leader>w', Util.close_command)
map('n', 'gx', function() require("essentials").go_to_url() end)
map('n', '<leader>cs', function() require("essentials").cheat_sh() end)

--> Telescope mappings
map('n', '<leader>ff', cmd "Telescope find_files")
map('n', '<leader>fg', cmd "Telescope live_grep")
map('n', '<leader>fs', cmd "Telescope grep_string")
map('n', '<leader>fo', cmd "Telescope oldfiles")

--> WINDOW Control
map('n', '<C-h>'    , '<C-w>h')
map('n', '<C-j>'    , '<C-w>j')
map('n', '<C-k>'    , '<C-w>k')
map('n', '<C-l>'    , '<C-w>l')
map('n', '<A-Down>', '<C-w>-')
map('n', '<A-Up>'  , '<C-w>+')

--> Move selected line / block of text in visual mode
map("x", "<A-k>", ":move '<-2<CR>gv-gv")
map("x", "<A-j>", ":move '>+1<CR>gv-gv")
map("n", "<A-j>", ":move .+1<CR>==")
map("n", "<A-k>", ":move .-2<CR>==")

--> OLD
map('n', '<Space>'  , '<Nop>')
map('n', '<leader>a', 'ggVG')
map('i', 'jk'       , '<Esc>')
map('n', 'n'        , 'nzz')
map('n', '<TAB>'    , '<cmd>bnext<CR>')
map('n', '<S-TAB>'  , '<cmd>bprevious<CR>')
map('v', '<'        , '<gv')
map('v', '>'        , '>gv')
map('n', '>'        , '>>')
map('n', '<'        , '<<')

-- }}}

-- {{{ -- Plug configs
local cfg_cmp = function()
    local cmp = require('cmp')

    local kind_icons = {
        Text = ' ', Method = ' ', Function = ' ', Constructor = ' ', Field = ' ', Variable = ' ', Class = ' ', Interface = ' ',
        Module = ' ', Property = ' ', Unit = ' ', Value = ' ', Enum = ' ', Keyword = ' ', Snippet = ' ', Color = ' ', File = ' ',
        Reference = ' ', Folder = ' ', EnumMember = ' ', Constant = ' ', Struct = ' ', Event = ' ', Operator = ' ', TypeParameter = ' ',
    }
    -- Great for other themes, not for gruvbox tho
    -- for _, k in ipairs(vim.tbl_keys(kind_icons)) do vim.cmd("hi CmpItemKind"..k.." gui=reverse") end
    cmp.setup {
        formatting = {
            fields = { 'kind', 'abbr', 'menu' },
            format = function(_, item)
                item.kind = (' ' .. kind_icons[item.kind]) or " "
                return item
            end
        },
        window = { documentation = { border = "shadow" }, completion={side_padding=0} },
        snippet = { expand=function(o) vim.snippet.expand(o.body) end },
        mapping = cmp.mapping.preset.insert {
            ['<C-b>'] = cmp.mapping.scroll_docs(-1),
            ['<C-f>'] = cmp.mapping.scroll_docs(1),
            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ['<Tab>'] = cmp.mapping(function(fb) (vim.snippet.active() and vim.snippet.jump or fb)(1) end, { "i", "s" })
        },
        sources = cmp.config.sources {
            { name = 'path' },
            { name = 'nvim_lsp' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'nvim_lua' },
            { name = 'neorg'},
            { name = 'buffer' },
        },
        experimental = { ghost_text = true }
    }

    cmp.setup.cmdline(':', { mapping=cmp.mapping.preset.cmdline(), sources={{name="cmdline", keyword_length=3}} })
end

local cfg_telescope = {
    defaults = {
        borderchars = {
            prompt = { "─", "│", "─", "│", "╭", "┬", "┤", "├" },
            results = { " ", "│", "─", "│", "│", "│", "┴", "╰" },
            preview = { "─", "│", "─", " ", "─", "╮", "╯", "─" },
        },
        results_title = false, sorting_strategy = "ascending",
        layout_config = { prompt_position="top" },
        file_ignore_patterns = vim.opt.wildignore:get()
    }
}

local cfg_neorg = {
    load = {
        ["core.defaults"] = {}, ["external.jupyter"] = {}, ["core.concealer"] = {},
        ["core.completion"] = { config={ engine="nvim-cmp" } },
        ["core.presenter"] = { config={ zen_mode = "zen-mode" } },
        ["core.itero"] = {}, ["external.exec"] = {}, ["core.ui.calendar"] = {},
        ["core.summary"] = { config = { strategy = "default" } }
    }
}

local cfg_staline = function()
    Bruh = function() require("mpv").toggle_player() end
    vim.g.lsp_status = ""

    vim.api.nvim_create_autocmd("LspProgress", {
        callback = function(nice)
            local status = nice.data.result.value.percentage or ""
            vim.g.lsp_status = type(status) == "number" and status.."%" or ""
            vim.cmd.redrawstatus()
        end
    })

    vim.g.mpv_visualizer = ""
    require("staline").setup({
        defaults = { true_colors=true },
        sections={
            left = { '  ', 'mode', '  ', 'git_branch', '   ', 'lsp', '   %{g:lsp_status}' },
            right = { '  %10@v:lua.Bruh@󰎆 %X %{g:mpv_visualizer}', 'line_column', '  ' }-- , vim.env.VIRTUAL_ENV }
        }
    })
    require("stabline").setup({ font_active="none", stab_start="  %#Identifier#  ", stab_bg='none', stab_left='', inactive_fg='none', fg="#95c561" })
end

-- }}}

-- {{{ -- Lazy
local plugins = {

    --> Temporary and testing
    { 'sindrets/diffview.nvim', config=true },
    -- { 'tiagovla/scope.nvim', config=true },
    -- { 'olimorris/onedarkpro.nvim' },
    -- { 'linux-cultist/venv-selector.nvim', config=true, ft="python" },
    { '3rd/image.nvim', opts={ backend="kitty", integrations={ neorg = { enabled=true } } }, ft="norg" },
    -- { 'rest-nvim/rest.nvim', config=true },
    { 'sainnhe/gruvbox-material' },
    -- { 'willothy/flatten.nvim', lazy=false, config=true },

    --> My Useless lil plugins
    -- { 'tamton-aquib/mpv.nvim', config={setup_widgets=true}, lazy=true },
    { 'tamton-aquib/nvim-market', import="nvim-market.plugins", config=true },
    { 'tamton-aquib/staline.nvim', config=cfg_staline, event="ColorScheme" },
    { 'tamton-aquib/flirt.nvim', config=true, cond=not vim.g.neovide },
    { 'tamton-aquib/stuff.nvim' },
    { 'tamton-aquib/essentials.nvim', lazy=true },

    --> THEMES AND UI
    { 'DaikyXendo/nvim-web-devicons', opts={override={norg={icon=" ", color="#4878be", name="neorg"}} }, lazy=true },
    { 'norcalli/nvim-colorizer.lua', cmd="ColorizerToggle" },
    { 'lewis6991/gitsigns.nvim', config=true },
    { 'nvim-tree/nvim-tree.lua', opts={ renderer={ indent_markers={ enable=true } } } },
    { 'declancm/cinnamon.nvim', config=true, keys={"<C-d>", "<C-u>"}, cond=not vim.g.neovide },

    --> LSP and COMPLETION
    { 'neovim/nvim-lspconfig', lazy=true },
    { 'hrsh7th/nvim-cmp', config=cfg_cmp, event={"InsertEnter", "CmdlineEnter"}, lazy=true,
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-buffer'
        }
    },

    --> Telescope, TREESITTER, NEORG
    { 'nvim-lua/plenary.nvim', lazy=true },
    { 'nvim-telescope/telescope.nvim', opts=cfg_telescope, cmd="Telescope" },
    { 'nvim-treesitter/nvim-treesitter', config={highlight = {enable=true}, indent = {enable=true}}  },
    { 'nvim-neorg/neorg', ft="norg", lazy=true, opts=cfg_neorg, dependencies={"tamton-aquib/neorg-jupyter"} },

    --> GENERAL PURPOSE
    { 'notjedi/nvim-rooter.lua', config=true },
    { 'nvim-focus/focus.nvim', lazy=true, opts={ui = {cursorline=false, signcolumn=false}}, event="WinEnter" },
    { 'windwp/nvim-autopairs', config=true, event="InsertEnter" },
    { 'shellRaining/hlchunk.nvim', opts={ blank={enable=false}, chunk={chars={right_arrow="─"} }} },
}

require("lazy").setup({plugins}, {
    ui = { pills=false }, install = { colorscheme = {"retrobox"} },
    performance = { rtp = { disabled_plugins = {
        "python3_provider", "node_provider", "2html_plugin", "getscript", "getscriptPlugin",
        "gzip", "matchit", "tar", "tarPlugin", "rrhelper", "spellfile_plugin", "vimball",
        "vimballPlugin", "zip", "zipPlugin", "tutor", "rplugin", "spellfile", "tarPlugin",
        "man", "logiPat", "netrwSettings", "netrwFileHandlers", "remote_plugins",
        "netrw", "editorconfig", "netrwPlugin", "tohtml"
    }}
}})
-- }}}

-- {{{ -- LSP
vim.lsp.handlers["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = Util.border})
vim.lsp.handlers["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = Util.border})

vim.diagnostic.config({
    virtual_text = false,
    signs = { text = { '', '', '', '' } }, -- {"", "", "", "", "﫠"}
    float = {
        border = Util.border, suffix = '', focusable=false,
        header = { "  Diagnostics", "String" },
        prefix = function(_, _, _) return "  " , "String" end, -- icons:        ﬌  
    }
})

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')
local lspconfig = require("lspconfig")

local s = {
    pyright={}, tsserver={}, biome = {}, cssls={}, rust_analyzer={}, svelte = {},
    lua_ls = {
        settings = {
            Lua = {
                diagnostics={globals={'vim'}},
                runtime={version="LuaJIT"},
                path = runtime_path,
                workspace = { library = vim.api.nvim_get_runtime_file('', true), checkThirdParty=false },
            }
        }
    }
}

for server, opt in pairs(s) do
    opt.capabilities = require("cmp_nvim_lsp").default_capabilities()
    lspconfig[server].setup(opt)
end
-- }}}

-- {{{ -- MISC
vim.cmd.colorscheme("gruvbox-material")
vim.cmd [[hi link @punctuation.bracket Red]]
vim.cmd [[hi link @constructor.lua Red]]

function UF()
    local title = vim.fn.getline(vim.v.foldstart)--[[@as string]]:gsub([[%-%- %{%{%{ %-%- ]], "")
    return (" "):rep(math.floor(vim.o.columns - title:len()) / 2) .. title
end

vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = vim.fn.stdpath("config") .. "/init.lua",
    callback = function()
        vim.cmd [[setl fdm=marker fdls=-1 fdl=0 nonu nornu scl=no]]
        vim.keymap.set('n', '<CR>', 'za', {buffer=0})
        vim.opt_local.foldtext = 'v:lua.UF()'
        local main_text = "-- [[ Noice ]] --"
        vim.api.nvim_buf_set_extmark(0, vim.api.nvim_create_namespace("taj0023"), 0, 0, {
            virt_text = {{ Util.center({main_text})[1] , "Function"}}
        })
    end
})

vim.g.neovide_underline_automatic_scaling = true
vim.g.neovide_scale_factor = 1.0
vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0
vim.g.neovide_floating_shadow = 'v:true'
vim.g.neovide_floating_z_height = 10
vim.g.neovide_confirm_quit = true

-- }}}
