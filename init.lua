

-- {{{ -- Settings

vim.loader.enable()
vim.g.did_install_default_menus = 1
vim.g.gruvbox_material_background = 'hard'
vim.g.python3_host_prog = '/usr/bin/python'
vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_float_style = 'none'

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.notify("Installing lazy.nvim...")
    vim.system({"git", "clone", "--branch=stable", "--filter=blob:none", "https://github.com/folke/lazy.nvim", lazypath}):wait()
end
vim.opt.runtimepath:prepend(lazypath)

local opts = {
	General = {
		exrc = true, spell = false, wrap = false, linebreak = true, ruler = false,
		conceallevel = 2, timeoutlen = 300, updatetime = 500, cmdheight = 0, winborder = 'rounded',
        wildignore = { '*.pyc,__pycache__,node_modules,*.lock,package%-lock%.json,yarn%.lock,target' },
	},
	Backup = { backup = false, writebackup = false, swapfile = false },
	Layout = {
		scrolloff = 5, splitright = true, splitbelow = true, pumheight = 10,
		incsearch = true, showmode = false, showtabline = 2, laststatus = 3,
	},
	Edit = {
		completeopt = "menu,menuone,noselect,popup",
		virtualedit = "block", smartcase = true, ignorecase = true,
		clipboard = "unnamedplus", iskeyword = vim.o.iskeyword..",-"
	},
	Fold = {
		foldmethod = "expr",
		foldlevelstart = 99,
		foldexpr = 'v:lua.vim.treesitter.foldexpr()',
		foldtext = 'v:lua.require("essentials").simple_fold()'
	},
	Ui = {
		pumblend = 30, inccommand = "split", termguicolors = true, number = true, signcolumn = "yes:2",
        guifont = "IosevkaTerm NF:h9", -- guifont = "MonoLisa:h8",
		rnu = true, shortmess = "tF".."TIcC".."as".."WoO",
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
        vim.ui.select = essentials.ui_select
        vim.notify = essentials.ui_notify
    end
end)

-- }}}

-- {{{ -- Utils
local Util = {}

Util.launchIDE = function(ide)
    local buffers = vim.api.nvim_list_bufs()
    local fileNames = {}

    for _, buffer in ipairs(buffers) do
        if (vim.api.nvim_buf_is_valid(buffer) and vim.bo[buffer].buflisted) then
            local fileName = vim.api.nvim_buf_get_name(buffer)

            if (vim.api.nvim_get_current_buf() == buffer) then
                local location = vim.api.nvim_win_get_cursor(0)
                fileName = fileName .. ":" .. location[1] .. ":" .. location[2] + 1
                table.insert(fileNames, 1, fileName)
            else
                table.insert(fileNames, fileName)
            end
        end
    end

    local cwd = vim.fn.getcwd()
    local cmd = ide == "vscode" and "!code -g "..cwd.." " or "!idea64.exe "
    vim.cmd(cmd .. table.concat(fileNames, " "))
end

--> Different kinds of Borders
-- Util.border = ({
--     { "╒", "═", "╕", "│", "╛", "═", "╘", "│" },
--     { "▁", "▁", "▁", "▕", "▔", "▔", "▔", "▏", },
--     { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" },
--     { "", "", "", " ", "", "", "", " " },
-- })[vim.g.neovide and 1 or 3]
-- })[4]

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

        -- "","", "", "", "", "", "", "", "", "T     A     J        "
        "","", "", "", "", "", "", "", "", "N   E   O   V   I   M        "
        -- [[ ███▄    █     ▒█████      ██▓    ▄████▄     ▓█████   ]],
        -- [[ ██ ▀█   █    ▒██▒  ██▒   ▓██▒   ▒██▀ ▀█     ▓█   ▀   ]],
        -- [[▓██  ▀█ ██▒   ▒██░  ██▒   ▒██▒   ▒▓█    ▄    ▒███     ]],
        -- [[▓██▒  ▐▌██▒   ▒██   ██░   ░██░   ▒▓▓▄ ▄██▒   ▒▓█  ▄   ]],
        -- [[▒██░   ▓██░   ░ ████▓▒░   ░██░   ▒ ▓███▀ ░   ░▒████▒  ]],
        -- [[░ ▒░   ▒ ▒    ░ ▒░▒░▒░    ░▓     ░ ░▒ ▒  ░   ░░ ▒░ ░  ]],
        -- [[░ ░░   ░ ▒░     ░ ▒ ▒░     ▒ ░     ░  ▒       ░ ░  ░  ]],
        -- [[   ░   ░ ░    ░ ░ ░ ▒      ▒ ░   ░              ░     ]],
        -- [[         ░        ░ ░      ░     ░ ░            ░  ░  ]],
        -- [[                                 ░                    ]]
    }
    local arg = vim.fn.argv(0)
    if (vim.bo.ft ~= "lazy") and (vim.bo.ft ~= "netrw") and (arg == "") then
        -- vim.fn.matchadd("Error", '[░▒]')
        -- vim.fn.matchadd("Function", '[▓█▄▀▐▌]')
        -- vim.fn.matchadd("Function", 'T     A     J')
        vim.fn.matchadd("Function", 'N   E   O   V   I   M')
        local map = function(lhs, rhs) vim.keymap.set('n', lhs, rhs, {silent=true, buffer=0}) end
        local keys = {K='kitty/kitty.conf', W='wezterm/wezterm.lua', I='nvim/init.lua', A='alacritty/alacritty.toml', G='ghostty/config', H='hypr/hyprland.conf'}
        map('P', '<cmd>Telescope oldfiles<CR>'); map('q', '<cmd>q<CR>'); map('o', '<cmd>e #<1<CR>') -- edit the last edited file
        vim.api.nvim_put(Util.center(header), "l", true, true)
        -- vim.cmd [[silent! setl nonu nornu nobl acd ft=dashboard bh=wipe bt=nofile]]
        vim.cmd [[silent! setl nonu nornu nobl ft=dashboard bh=wipe bt=nofile]]
        for k,f in pairs(keys) do map(k,'<cmd>e '..xdg..f..' | setl noacd<CR>') end
    end
end)

--> Closing Windows and buffers
Util.close_command = function()
    if vim.bo.modified then print("buf not saved!") return end
    local total = #vim.tbl_filter(function(buf)
        return vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_name(buf) ~= ""
    end, vim.api.nvim_list_bufs())

    local quit_cmd = #vim.api.nvim_list_wins() > 1 and 'fclose' or 'q'
    vim.cmd(total == 1  and quit_cmd or 'bd')
end

-- }}}

-- {{{ -- Autocmds

--> Wrapper function
local au = function(events, ptn, cb) vim.api.nvim_create_autocmd(events, {pattern=ptn, [type(cb)=='function' and 'callback' or 'command']=cb}) end

au("Filetype", "typescriptreact,javascript,typescript,javascriptreact,dart,json", "set ts=2 sw=2")

--> LSP Related
au("BufWritePre", "*.rs,*.svelte,*.tsx,*.ts", function() vim.lsp.buf.format() end)
au("FileType", "json,jsonc,http", "set cole=0")
au("FileType", "markdown", "setl cole=3")
au("FileType", "norg,oil", "setl scl=yes:4 nonu nornu")

--> OLD
au("BufReadPost", "*.lua", [[call matchadd("Keyword", "--> \\zs.*\\ze$")]])
au("BufEnter", "*", 'setl fo-=cro')
au("BufReadPost", "*", function() require("essentials").last_place() end)
au("TextYankPost", "*", function() vim.highlight.on_yank({higroup="Visual", timeout=200}) end)
au("TermOpen", "term://*", "setl nonu nornu scl=no | star")
au("UIEnter", "*", Util.splash_screen)

--> Commands
-- local command = vim.api.nvim_create_user_command
local command = function(cmd, exec, os) vim.api.nvim_create_user_command(cmd, exec, os or {}) end

command("CertificateInfo", "execute 'term openssl x509 -in ' . expand('%') . ' -text -noout'")
command("Jq", "execute '.!jq'")

command("Format", vim.lsp.buf.format)
command("Mess", function() require("essentials").messages() end)
command("Vscode", function() Util.launchIDE("vscode") end)
command("Intellij", function() Util.launchIDE("intellij") end)

command("CopyDate", function() vim.fn.setreg("+", os.date("%Y%m%d%H%M%S")) vim.notify("Copied timestamp to clipboard!") end)
command("Date", function() vim.fn.setreg("+", os.date("%Y%m%d%H%M%S")) vim.notify("Copied timestamp to clipboard!") end)
command("PP", function() require("essentials").null_pointer() end, {range='%'})
command("Rfc", function() vim.snippet.expand("const ${1:Component} = () => {\n    return (\n        ${0}\n    );\n}\n\nexport default ${1};") end)
-- }}}

-- {{{ -- Mappings

vim.g.mapleader = " "
vim.g.maplocalleader = ","
local function map(key, func, mode) vim.keymap.set(mode or 'n', key, func, { silent = true }) end
local function cmd(s) return "<CMD>"..s.."<CR>" end

--> Test mappings

-- Java DAP setup
map('<leader>jt', cmd 'JavaTestDebugCurrentClass')
map('<leader>jm', cmd 'JavaTestDebugCurrentMethod')
map('<leader>jr', cmd 'JavaTestViewLastReport')
map('<Cr>', cmd 'DapToggleBreakpoint')
map('<Right>', cmd 'DapContinue')
map('<Down>', cmd 'DapStepOver')
map('<leader>do', function() require("dapui").toggle() end)

map('-',          cmd 'Oil')
map('<leader>c',  function() require("essentials").konsole() end)
map('gQ',         cmd 'vsp | Oil ~/norg/ONDC/')
map('<leader>ii', function() require("nvim-market").install_picker() end)
map('<leader>iu', function() require("nvim-market").remove_picker() end)
map('<leader>or', cmd 'OverseerRun')
map('<leader>ot', cmd 'OverseerToggle')
map('<leader>v',  function() vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines }) end)
map('gl',         function() vim.diagnostic.open_float({focusable=true}) end)

map('<Esc>',      '<CMD>nohl<Bar>echo<CR>')
map('jk',         '<C-f><Cmd>echo | setl nonu nornu scl=no | resize 1<Cr>', { 'c' })
map('<leader>gn', cmd "Gitsigns next_hunk")
map('<leader>gp', cmd "Gitsigns prev_hunk")
map('<leader>gb', cmd "Gitsigns blame_line")
map('<leader>gd', cmd "Gitsigns preview_hunk_inline")
map('<leader>gr', cmd "Gitsigns reset_hunk")
map('<leader>gt', function() vim.cmd("Diffview".. (next(require('diffview.lib').views) == nil and "Open" or "Close")) end)

map('<leader>l',  cmd "tabnew | term lazygit")
map('<C-t>',      function() require("essentials").toggle_term("fish", 'v', true) end, {'n', 't'})
map('<leader>p',  cmd 'Lazy')
map('<Esc><Esc>', [[<C-\><C-n>]], 't')
map('gh',         function() vim.cmd.help(vim.fn.expand('<cword>')) end)

--> General Mappings
map('<leader>e', function() require("nvim-tree.api").tree.toggle({find_file=true}) end)
map('<leader>q', function() require("essentials").toggle_quickfix() end)
map('<leader>z', cmd 'NoNeckPain')
map('<leader>n', cmd 'Neogen')
map('<C-n>',     cmd "cnext")
map('<C-p>',     cmd "cprev")

--> stuff.nvim keymaps (https://github.com/tamton-aquib/stuff.nvim)
map('gC', function() require("calc").toggle() end)
map('gS', function() require("stalk").stalk() end)
map('gs', function() require("scratch").toggle() end)
map('gB', function() require("bt").toggle() end)
map('gT', function() require("tmpclone").clone() end)
map('gp', function() require("mpv").toggle_player() end)
map('gP', function() require("dep").check() end)

--> Lsp mappings
map('gD', vim.lsp.buf.definition)
map('gd', '<cmd>vs | lua vim.lsp.buf.definition()<CR>')

--> essentials.nvim mappings ( https://github.com/tamton-aquib/essentials.nvim )
map('<F2>'      , function() require("essentials").rename() end)
map('<leader>r' , function() require("essentials").run_file() end)
map('<leader>s' , function() require("essentials").swap_bool() end)
map('<leader>w',  Util.close_command)
map('gx',         function() require("essentials").go_to_url() end)

--> WINDOW Control
map('<C-h>', cmd 'wincmd h', { 'n', 't' })
map('<C-j>', cmd 'wincmd j', { 'n', 't' })
map('<C-k>', cmd 'wincmd k', { 'n', 't' })
map('<C-l>', cmd 'wincmd l', { 'n', 't' })
map('<A-Down>', '<C-w>-')
map('<A-Up>'  , '<C-w>+')

--> Move selected line / block of text in visual mode
map("<A-k>", ":move '<-2<CR>gv-gv", 'x')
map("<A-j>", ":move '>+1<CR>gv-gv", 'x')
map("<A-j>", ":move .+1<CR>==")
map("<A-k>", ":move .-2<CR>==")

-->  Snacks picker
map("<leader><space>", function() Snacks.picker.smart() end)
map("<leader>ff", function() Snacks.picker.files({ exclude=vim.opt.wildignore:get() }) end)
map("<leader>fp", function() Snacks.picker.projects() end)
map("<leader>fo", function() Snacks.picker.recent() end)
map("<leader>fg", function() Snacks.picker.grep() end)
map("<leader>fs", function() Snacks.picker.grep_word() end)
map("<leader>fh", function() Snacks.picker.help() end)
map("<leader>fr", function() Snacks.picker.resume() end)
map("<leader>fd", function() Snacks.picker.lsp_workspace_symbols() end)
map("<leader>z",  function() Snacks.zen() end)

--> OLD
map('<Space>'  , '<Nop>')
map('<leader>a', 'ggVG')
map('jk'       , '<Esc>', 'i')

map('n', cmd 'exe "norm! nzz" | lua vim.defer_fn(vim.cmd.nohl, 3000)')
map('N', cmd 'exe "norm! Nzz" | lua vim.defer_fn(vim.cmd.nohl, 3000)')

map('<TAB>'    , cmd 'bnext')
map('<S-TAB>'  , cmd 'bprevious')
map('<'        , '<gv', 'v')
map('>'        , '>gv', 'v')
map('>'        , '>>')
map('<'        , '<<')

-- }}}

-- {{{ -- Plug configs

local cfg_kulala = { global_keymaps = true, global_keymaps_prefix = "<leader>k", ui = { show_icons = "signcolumn" } }

local cfg_blink = {
    enabled = function() return not vim.tbl_contains({ "prompt" }, vim.bo.filetype) end,
    keymap = { preset = 'enter' },
    appearance = { nerd_font_variant = 'normal' },
    completion = {
        list = {
            selection = {
                preselect = function(ctx) return ctx.mode ~= "cmdline" end,
                auto_insert = function(ctx) return ctx.mode == "cmdline" end,
            },
        },
        documentation = { auto_show = true }
    },
    sources = { default = { 'lsp', 'path', 'snippets', 'buffer', 'cmdline' } },
    fuzzy = { implementation = "lua" }
}

local cfg_lsp = function()
    local servers = {
        ts_ls = {}, tailwindcss = {}, cssls = {}, eslint = {},
        basedpyright = {}, rust_analyzer = {},
        lua_ls = { settings = { Lua = { diagnostics = { globals = { "vim", "Snacks" } } } } },
    }

    vim.iter(servers):map(function(server, settings)
        vim.lsp.config[server] = vim.tbl_extend("force", vim.lsp.config[server], settings)
        vim.lsp.enable(server)
    end):totable()
end


local cfg_snacks = {
    picker = {
        ui_select = false,
        sources = {
            files = { layout = { preview = false } },
            grep = { layout = { preview = false } },
            smart = { layout = { preview = false } },
        },
        prompt = "     ",
        layout = { layout = { box = "horizontal", width = 0.7, height = 0.7, preview = false } }
    },
    scroll = { animate = { easing = "outQuart" }, filter = function(buf) return vim.bo[buf].filetype ~= "json" or vim.bo[buf].buftype ~= "terminal" end },
    dim = { enabled = true },
    words = { debounce = 20 },
    indent = { chunk = { enabled = true, char = { arrow = "─" } } }
}

local cfg_neorg = {
    load = {
        ["core.defaults"] = {}, ["core.concealer"] = { config={ icons = { code_block = { conceal=true, content_only=true } } } },
        -- ["core.completion"] = { config={ engine="nvim-cmp" } },
        ["core.presenter"] = { config={ zen_mode = "zen-mode" } },
        ["core.itero"] = {}, ["core.ui.calendar"] = {}, ["core.export"] = {},
        ["core.todo-introspector"] = {},
        ["core.esupports.metagen"] = { config = {update_date=false} },
        ["core.esupports.indent"] = { config = { indents = { _ = { indent = 2 } } } },
    }
}

local cfg_nvimtree = {
    view = { preserve_window_proportions = true, adaptive_size = true },
    update_focused_file = { enable = true, update_root = true },
    renderer = { indent_markers = { enable = true } }
}


vim.g.lsp_status = ""
vim.g.mpv_visualizer = ""
local cfg_staline = function()
    vim.api.nvim_create_autocmd("LspProgress", {
        callback = function(o)
            local status = o.data.params.value.percentage or ""
            vim.g.lsp_status = type(status) == "number" and status.."%" or ""
            vim.cmd.redrawstatus()
        end
    })

    local virtual_env = function()
        local nice = vim.fn.fnamemodify(vim.env.VIRTUAL_ENV or '', ':t')
        return nice ~= '' and '('.. nice ..')' or ''
    end

    local overseer_status = function()
        local tasks = require("overseer.task_list").list_tasks({ unique = true })
        local res = ''
        vim.iter(tasks):map(function(task)
            local tstatus = task.status
            if tstatus == 'RUNNING' then res = res .. ' ' end
        end)
        return res
    end

    require("staline").setup({
        defaults = { true_colors=true, inactive_color="#07080f", inactive_bg="none" },
		special_table = { mpv = { 'MPV', ' ' } },
        sections = {
            left = { '  ', 'mode', '  ', 'git_branch', '   ', 'lsp', '   %{g:lsp_status}' },
            right = { overseer_status, "  %@v:lua.require'mpv'.toggle_player@󰎆 %X %{g:mpv_visualizer}", virtual_env, 'line_column', '  ' }
        }
    })
    require("stabline").setup({ font_active="none", stab_start="  %#Identifier#  ", stab_bg='none', stab_left='', inactive_fg='none', fg="#95c561" })
end
-- }}}

-- {{{ -- Lazy

local plugins = {

    --> Temporary and testing
    { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }, config = true },

    { 'nvim-java/nvim-java', config = function()
        require("java").setup({ jdk = { auto_install = false } })
        require("lspconfig").jdtls.setup({})
    end },
    { 'danymat/neogen', config = true },

    { "mistweaverco/kulala.nvim", ft = { "http", "rest" }, opts = cfg_kulala },
    { 'nvim-flutter/flutter-tools.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, config = true },
    -- { 'norcalli/nvim-colorizer.lua', cmd = "ColorizerToggle" },
    -- { "r-pletnev/pdfreader.nvim", dependencies = { "nvim-telescope/telescope.nvim" }, config = true },
    -- {
    --     "kndndrj/nvim-dbee",
    --     dependencies = { "MunifTanjim/nui.nvim" },
    --     build = function() require("dbee").install() end,
    --     config = function() require("dbee").setup() end,
    -- },
    -- { "pysan3/autosession.nvim", opts = { restore_on_setup = false }, event = { "VeryLazy" }, },
    -- { 'sindrets/diffview.nvim', config=true },
    -- { 'willothy/flatten.nvim', opts={window = { open="smart" } } },
    -- { 'stevearc/quicker.nvim', config=true },

    { 'stevearc/overseer.nvim', opts = {} },
    { 'nvim-treesitter/nvim-treesitter-context', config=function() require("treesitter-context").setup { enable = true } end, ft="json" },
    { "youyoumu/pretty-ts-errors.nvim", config = true },
    { "supermaven-inc/supermaven-nvim", config = true },
    { "folke/snacks.nvim", priority = 1000, opts = cfg_snacks },

    { 'dmmulroy/tsc.nvim', opts = { enable_progress_notifications = true } },
    { 'windwp/nvim-ts-autotag', config = true },

    --> My Useless lil plugins
    { 'tamton-aquib/staline.nvim', config = cfg_staline, event="ColorScheme", dev=true },
    { 'tamton-aquib/stuff.nvim', lazy = true },
    { 'tamton-aquib/essentials.nvim', lazy = true },
    -- { 'tamton-aquib/flirt.nvim', opts={ speed=99, custom_filter=function(_, wincfg) return wincfg.zindex == 69 end }, cond=not vim.g.neovide },
    -- { 'tamton-aquib/mpv.nvim', opts={setup_widgets=true}, lazy=true, dev=true },
    -- { 'tamton-aquib/nvim-market', import="nvim-market.plugins", config=true, lazy=true, dev=true },
    -- { 'tamton-aquib/duck.nvim', config=true },
    -- { 'tamton-aquib/keys.nvim', opts={} },
    -- { 'tamton-aquib/zone.nvim', opts={after=5, style='dvd'}, dev=true },

    --> THEMES AND UI
    { 'sainnhe/gruvbox-material', config = function() vim.cmd.colorscheme("gruvbox-material") end },
    { 'nvim-tree/nvim-web-devicons', opts = {}, event = "VeryLazy" },
    { 'lewis6991/gitsigns.nvim', config = true },
    { 'nvim-tree/nvim-tree.lua', opts = cfg_nvimtree, lazy = true },
    { 'stevearc/oil.nvim', config = true },

    --> LSP and COMPLETION
    { 'neovim/nvim-lspconfig', config = cfg_lsp },
    { 'Saghen/blink.cmp', opts = cfg_blink, opts_extend = { "sources.default" } },
    { 'mason-org/mason.nvim', config = true },
    { "folke/lazydev.nvim", config = true },

    --> Telescope, TREESITTER, NEORG, REST
    { 'nvim-treesitter/nvim-treesitter', opts = { highlight = { enable = true }, indent = { enable = true } }, main = "nvim-treesitter.configs" },
    { "vhyrro/luarocks.nvim", opts = { rocks = { "magick" } } },
    { "nvim-neorg/neorg", ft = "norg", dependencies = { "luarocks.nvim" }, opts = cfg_neorg },

    --> GENERAL PURPOSE
    { 'notjedi/nvim-rooter.lua', config = true },
    { 'nvim-focus/focus.nvim', opts = { ui = { cursorline = false }, excluded_windows = { 'fyler', 'NvimTree', 'dbui', 'dbee', 'no-neck-pain', 'DiffviewFiles' } } },
    { 'windwp/nvim-autopairs', config = true, event = "InsertEnter" },
    { 'tiagovla/scope.nvim', config = true },
}

require("lazy").setup({ plugins }, {
    ui = { pills = false, border = "none" },
    install = { colorscheme = { "gruvbox-material", "retrobox" } },
	dev = { path="~/Projects/Neovim/", patterns = { "tamton-aquib" }, fallback = true },
})
-- }}}

-- {{{ -- LSP

vim.diagnostic.config({
	virtual_text = false,
	signs = { text = { '', '', '', '' } }, -- {"", "", ""}
	float = {
		border = 'rounded',
		suffix = '',
        source = true,
		focusable = true,
		header = { "  Diagnostics", "String" },
		prefix = function(_, _, _) return "  " , "String" end, -- icons:       
	}
})

vim.lsp.config('*', {
    capabilities = require('blink.cmp').get_lsp_capabilities(vim.lsp.protocol.make_client_capabilities()),
    on_init = function(client) client.server_capabilities.semanticTokensProvider = nil end
})
-- }}}

-- {{{ -- MISC

--> Custom Highlights
vim.cmd [[hi link @punctuation.bracket Red | hi link @constructor.lua Red]]
vim.cmd [[hi WarningText gui=underline | hi ErrorText gui=underline | hi TSDanger gui=reverse]]
vim.cmd [[hi StatusLine guibg=none | hi TabLineFill guibg=none]]
vim.defer_fn(function() vim.cmd [[hi! BlinkCmpMenu guibg=none | hi! BlinkCmpMenuBorder guibg=none]] end, 500)
vim.fn.sign_define('DapBreakpoint', { text='', texthl='Error', linehl='', numhl='' })
vim.fn.sign_define('DapStopped', { text='󰋇 ', texthl='HealthSuccess', linehl='Visual', numhl='' })


function UF()
    local title = vim.fn.getline(vim.v.foldstart):gsub([[%-%- %{%{%{ %-%- ]], "")
    return (" "):rep(math.floor(vim.o.columns - title:len()) / 2) .. title
end

vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = vim.fn.stdpath("config") .. "/init.lua",
    callback = function()
        vim.cmd [[setl foldtext=v:lua.UF()]]
        vim.keymap.set('n', '<CR>', 'za', {buffer=0})
        vim.api.nvim_buf_set_extmark(0, vim.api.nvim_create_namespace("taj"), 0, 0, {
            virt_text = {{ Util.center({"-- [[ INIT.LUA ]] --"})[1] , "Function"}}
        })
    end
})

-- vim: fdm=marker fdls=-1 fdl=0 nonu nornu scl=no
-- -- }}}
