

-- {{{ -- Settings

vim.loader.enable()
vim.g.gruvbox_material_background = 'hard'
vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_float_style = 'blend'
vim.g.lsp_status = ""
vim.g.mpv_visualizer = ""
vim.g.stl_macro_name = ""

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
		scrolloff = 500, splitright = true, splitbelow = true, pumheight = 10,
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
		fillchars = { eob=' ', fold=' ', foldopen="", foldsep=" ", foldclose="", diff='╱' }
	},
	Tabspace = {
		shiftwidth = 4, tabstop = 4, softtabstop = 0, expandtab = true,
		smartindent = true, breakindent = true, smarttab = true
	}
}

for _, section in pairs(opts) do for k,v in pairs(section) do vim.opt[k] = v end end
-- vim.opt.statuscolumn = "%s %{foldlevel(v:lnum) <= foldlevel(v:lnum-1) ? ' ' : (foldclosed(v:lnum) == -1 ? ' ' : '')} %{v:relnum ? v:relnum : v:lnum} "

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

Util.center = function(dict)
    local padding = vim.fn.max(vim.fn.map(dict, 'strwidth(v:val)'))
    return vim.iter(dict):map(function(v) return (" "):rep(math.floor((vim.o.columns - padding) / 2)) .. v end):totable()
end

Util.splash_screen = function()
    local xdg = vim.fn.fnamemodify(vim.fn.stdpath("config") --[[@as string]], ":h").."/"
    local header = { "","", "", "", "", "", "", "", "", "N   ≡   O   V   I   M        " }
    local arg = vim.fn.argv(0)
    if (vim.bo.ft ~= "lazy") and (vim.bo.ft ~= "netrw") and (arg == "") then
        vim.fn.matchadd("Function", 'N   E   O   V   I   M')
        local map = function(lhs, rhs) vim.keymap.set('n', lhs, rhs, {silent=true, buffer=0}) end
        local keys = {K='kitty/kitty.conf', W='wezterm/wezterm.lua', I='nvim/init.lua', A='alacritty/alacritty.toml', G='ghostty/config', H='hypr/hyprland.conf', F='fish/config.fish'}
        map('P', '<cmd>Telescope oldfiles<CR>'); map('q', '<cmd>q<CR>'); map('o', '<cmd>e #<1<CR>')
        vim.api.nvim_put(Util.center(header), "l", true, true)
        vim.cmd [[silent! setl nonu nornu nobl ft=dashboard bh=wipe bt=nofile]]
        for k,f in pairs(keys) do map(k,'<cmd>e '..xdg..f..' | setl noacd<CR>') end
    end
end

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

au("Filetype", "typescriptreact,javascript,typescript,javascriptreact,dart,jsonc,json", "set ts=2 sw=2")
au("RecordingEnter", "*", function() vim.g.stl_macro_name = " " .. vim.fn.reg_recording() end)
au("RecordingLeave", "*", function() vim.g.stl_macro_name = "" end)
au("LspProgress", "*", function(o) local v = (o.data or {}).params.value; vim.g.lsp_status = v.percentage and (v.percentage .. "%") or ""; vim.cmd.redrawstatus() end)

--> LSP Related
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*.tsx,*.ts",
--   callback = function(args)
--     require("conform").format({ bufnr = args.buf })
--   end,
-- })
au("BufWritePre", "*.rs,*.svelte,*.tsx,*.ts", function() vim.lsp.buf.format() end)
-- au("FileType", "json,jsonc,http,markdown,md", "set cole=0")
au("FileType", "json,jsonc,http", "set cole=0")
au("FileType", "norg,oil", "setl scl=yes:4 nonu nornu")

--> OLD
au("BufReadPost", "*.lua", [[call matchadd("Keyword", "--> \\zs.*\\ze$")]])
au("BufEnter", "*", 'setl fo-=cro')
au("BufReadPost", "*", function() require("essentials").last_place() end)
au("TextYankPost", "*", function() vim.highlight.on_yank({higroup="Visual", timeout=200}) end)
au("TermOpen", "term://*", "setl nonu nornu scl=no | star")
au("UIEnter", "*", Util.splash_screen)

--> Commands
local command = function(cmd, exec, os) vim.api.nvim_create_user_command(cmd, exec, os or {}) end

command("CertificateInfo", "execute 'term openssl x509 -in ' . expand('%') . ' -text -noout'")
command("Jq", "execute '.!jq'")
command("Format", vim.lsp.buf.format)
command("Mess", function() require("essentials").messages() end)
command("Date", function() vim.fn.setreg("+", os.date("%Y%m%d%H%M%S")) vim.notify("Copied timestamp to clipboard!") end)
-- }}}

-- {{{ -- Mappings

vim.g.mapleader = " "
vim.g.maplocalleader = ","
local function map(mode, key, func) vim.keymap.set(mode, key, func, {silent=true}) end
local function cmd(s) return "<CMD>"..s.."<CR>" end

map('n', '<leader>db', cmd 'Dbee')

map('n', '<M-Enter>', cmd 'DapToggleBreakpoint')
map('n', '<Right>', cmd 'DapContinue')
map('n', '<Down>', cmd 'DapStepOver')
map('n', '<leader>do', cmd 'DapViewToggle!')
map('v', '<Cr>', function() require("dap.ui.widgets").hover() end)

map('n', '<leader>d', vim.diagnostic.setqflist)
map('n', '<leader>c', function() require("essentials").konsole() end)
map('n', 'gQ', cmd 'Fyler dir=/home/hi10143/Notes/ kind=split_left')
map('n', '<leader>or', cmd 'OverseerRun')
map('n', '<leader>ot', cmd 'OverseerToggle')
map('n', '<leader>v', function() vim.diagnostic.config({ virtual_lines = not vim.diagnostic.config().virtual_lines }) end)
map('n', 'gl', function() vim.diagnostic.open_float({ focusable=true }) end)

map('n', '<Esc>', '<CMD>nohl<Bar>echo<CR>')
map('c', 'jk', '<C-f><Cmd>echo | setl nonu nornu scl=no | resize 1<Cr>')
map('n', '<leader>gn', cmd "Gitsigns next_hunk")
map('n', '<leader>gp', cmd "Gitsigns prev_hunk")
map('n', '<leader>gb', cmd "Gitsigns blame_line")
map('n', '<leader>gd', cmd "Gitsigns preview_hunk_inline")
map('n', '<leader>gr', cmd "Gitsigns reset_hunk")
map('n', '<leader>gt', cmd "DiffviewToggle")

map('n', '<C-n>', cmd "cnext")
map('n', '<C-p>', cmd "cprev")

map('n', '<leader>l', cmd "tabnew | term lazygit")
map({'n', 't'}, '<C-t>', function() require("essentials").toggle_term("fish", 'v', true) end)
map('n', '<leader>p', cmd 'Lazy')
map('t', '<Esc><Esc>', [[<C-\><C-n>]])
map('n', 'gh', function() vim.cmd.help(vim.fn.expand('<cword>')) end)

map('n', '<leader>e', function() require("fyler").toggle({ kind = "split_left" }) end)
map('n', '<leader>q'   , function() require("essentials").toggle_quickfix() end)
map('n', '<leader>z'   , cmd 'NoNeckPain')

map('n', 'gs', function() require("scratch").toggle() end)
map('n', 'gB', function() require("bt").toggle() end)
map('n', 'gT', function() require("tmpclone").clone() end)
map('n', 'gp', function() require("mpv").toggle_player() end)

map('n', 'gD', vim.lsp.buf.definition)
map('n', 'gd', '<cmd>vs | lua vim.lsp.buf.definition()<CR>')

map('n', '<leader>r' , function() require("essentials").run_file() end)
map('n', '<leader>s' , function() require("essentials").swap_bool() end)
map('n', '<leader>w', Util.close_command)
map('n', 'gx', function() require("essentials").go_to_url() end)

map({ 'n', 't' }, '<C-h>', cmd 'wincmd h')
map({ 'n', 't' }, '<C-j>', cmd 'wincmd j')
map({ 'n', 't' }, '<C-k>', cmd 'wincmd k')
map({ 'n', 't' }, '<C-l>', cmd 'wincmd l')
map('n', '<A-Down>', '<C-w>-')
map('n', '<A-Up>'  , '<C-w>+')
map('n', '<A-Left>', cmd 'vert res +1')
map('n', '<A-Right>', cmd 'vert res -1')

--> Move selected line / block of text in visual mode
map("x", "<A-k>", ":move '<-2<CR>gv-gv")
map("x", "<A-j>", ":move '>+1<CR>gv-gv")
map("n", "<A-j>", ":move .+1<CR>==")
map("n", "<A-k>", ":move .-2<CR>==")

-->  Snacks picker
map("n", "<leader><space>", function() Snacks.picker.smart() end)
map("n", "<leader>ff", function() Snacks.picker.files({ exclude = vim.opt.wildignore:get() }) end)
map("n", "<leader>fo", function() Snacks.picker.recent() end)
map("n", "<leader>fg", function() Snacks.picker.grep() end)
map("n", "<leader>fs", function() Snacks.picker.grep_word() end)
map("n", "<leader>fr", function() Snacks.picker.resume() end)
map("n", "<leader>z",  function() Snacks.zen() end)

--> OLD
map('n', '<Space>'  , '<Nop>')
map('n', '<leader>a', 'ggVG')
map('i', 'jk'       , '<Esc>')

map('n', 'n', cmd 'exe "norm! nzz" | lua vim.defer_fn(vim.cmd.nohl, 3000)')
map('n', 'N', cmd 'exe "norm! Nzz" | lua vim.defer_fn(vim.cmd.nohl, 3000)')

map('n', '<TAB>'    , cmd 'bnext')
map('n', '<S-TAB>'  , cmd 'bprevious')
map('v', '<'        , '<gv')
map('v', '>'        , '>gv')
map('n', '>'        , '>>')
map('n', '<'        , '<<')

-- }}}

-- {{{ -- Plug configs

local cfg_kulala = { global_keymaps = true, global_keymaps_prefix = "<leader>k", ui = { show_icons = "signcolumn" } }

local cfg_blink = {
    enabled = function() return not vim.tbl_contains({ "prompt" }, vim.bo.filetype) end,
    keymap = { preset = 'enter' },
    completion = {
        list = {
            selection = {
                preselect = function(ctx) return ctx.mode ~= "cmdline" end,
                auto_insert = function(ctx) return ctx.mode == "cmdline" end,
            },
        },
        documentation = { auto_show = true },
        menu = { border = "none", draw = { treesitter = { "lsp" } } },
    },
    sources = { default = { 'lsp', 'path', 'snippets', 'buffer', 'cmdline' } },
    fuzzy = { implementation = "lua" }
}

local cfg_lsp = function()
    local servers = {
        ts_ls = {}, tailwindcss = {}, cssls = {}, eslint = {},
        -- basedpyright = {}, ty = {},
        rust_analyzer = {},
        emmylua_ls = { settings = { Lua = { diagnostics ={ globals = { "vim", "Snacks" } } } } },
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
        layout = {
            layout = { box = "horizontal", width = 0.7, height = 0.7, preview = false }
        }
    },
    -- scroll = { animate = { easing = "outQuart" }, filter  = function(buf) return vim.bo[buf].filetype ~= "json" and vim.bo[buf].buftype ~= "terminal" end },
    -- dim = { enabled = true },
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


local cfg_staline = function()
    require("staline").setup({
        defaults = { true_colors=true, inactive_color="#07080f", inactive_bg="none" },
		special_table = { mpv = { 'MPV', ' ' } },
        sections = {
            left = { '  ', 'mode', '  ', 'git_branch', '   ', '%#Purple#%{g:stl_macro_name}%#None#', ' ', 'lsp', '   %{g:lsp_status}' },
            right = { "  %@v:lua.require'mpv'.toggle_player@󰎆 %X %{g:mpv_visualizer}", 'line_column', '  ' }
        }
    })
    require("stabline").setup({ font_active="none", stab_start="  %#Identifier#  ", stab_bg='none', stab_left='', inactive_fg='none', fg="#95c561" })
end
-- }}}

-- {{{ -- Lazy

local plugins = {

    --> Temporary and testing
    {
        "A7Lavinraj/fyler.nvim",
        config = function()
            vim.cmd [[au FileType fyler vert resize 30]]
            require("fyler").setup {
                integrations = { icon = "nvim_web_devicons" },
                views = { finder = { follow_current_file = true, icon = { directory_collapsed = "  ", directory_expanded = "  ", } } }
            }
        end
    },

    { "igorlfs/nvim-dap-view", opts = { winbar = { controls = { enabled = true } } } },

    {
        "nvim-java/nvim-java",
        config = function()
            require("java").setup({ jdk = { auto_install = false }})

            vim.lsp.config("jdtls", {
                name = "jdtls",
                cmd = { "jdtls", "--jvm-arg=-javaagent:/home/hi10143/Downloads/lombok.jar" },
                cmd_env = { JAVA_HOME="/usr/lib/jvm/java-21-openjdk-amd64/", }
            })
            vim.lsp.enable("jdtls")
        end,
    },
    { 'mason-org/mason.nvim', opts = {} },
    -- {
    --     'stevearc/conform.nvim',
    --     opts = {
    --         formatters_by_ft = {
    --             javascript = { "prettierd", "prettier", stop_after_first = true },
    --             tsx = { "prettierd", "prettier", stop_after_first = true },
    --             jsx = { "prettierd", "prettier", stop_after_first = true },
    --             typescript = { "prettierd", "prettier", stop_after_first = true },
    --             typescriptreact = { "prettierd", "prettier", stop_after_first = true },
    --         }
    --     },
    -- },
    { "iamkarasik/sonarqube.nvim", config = true },
    { "mistweaverco/kulala.nvim", ft = { "http", "rest" }, opts = cfg_kulala },
    { "kndndrj/nvim-dbee", dependencies = { "MunifTanjim/nui.nvim" }, build = function() require("dbee").install("cgo") end, config = function() require("dbee").setup() end, },
    { "dlyongemallo/diffview.nvim", version = "*" },

    { 'stevearc/overseer.nvim', opts = {} },
    { 'nvim-treesitter/nvim-treesitter-context', config=function() require("treesitter-context").setup {enable=true} end, ft="json" },
    { "youyoumu/pretty-ts-errors.nvim", config = true },
    { "supermaven-inc/supermaven-nvim", config = true },
    { "folke/snacks.nvim", priority = 1000, opts = cfg_snacks },

    { 'tiagovla/scope.nvim', config=true },
    { 'dmmulroy/tsc.nvim', opts={ enable_progress_notifications = true } },
    { 'windwp/nvim-ts-autotag', opts={} },

    --> My Useless lil plugins
    { 'tamton-aquib/staline.nvim', config=cfg_staline, event="ColorScheme", dev=true },
    { 'tamton-aquib/stuff.nvim', lazy = true },
    { 'tamton-aquib/essentials.nvim', lazy = true },

    --> THEMES AND UI
    { 'sainnhe/gruvbox-material', config = function() vim.cmd.colorscheme("gruvbox-material") end },
    { 'nvim-tree/nvim-web-devicons', opts={}, event="VeryLazy" },
    { 'norcalli/nvim-colorizer.lua', cmd="ColorizerToggle" },
    { 'lewis6991/gitsigns.nvim', config=true },

    --> LSP and COMPLETION
    { 'neovim/nvim-lspconfig', config = cfg_lsp },
    { 'saghen/blink.cmp', opts = cfg_blink, opts_extend = { "sources.default" } },

    --> TREESITTER, NEORG
    { 'nvim-treesitter/nvim-treesitter', opts={highlight={enable=true}, indent={enable=true} }, main="nvim-treesitter.configs" },
    { "nvim-neorg/neorg", lazy = true, version = "*", config = cfg_neorg, ft="norg", },

    --> GENERAL PURPOSE
    { 'notjedi/nvim-rooter.lua', config=true },
    { 'windwp/nvim-autopairs', config=true, event="InsertEnter" },
}

require("lazy").setup({ plugins }, {
    ui = { pills=false }, install={ colorscheme = { "gruvbox-material", "retrobox"} },
	dev = { path="~/Projects/Neovim/", patterns = {"taj" }, fallback = true },
})
-- }}}

-- {{{ -- LSP

vim.diagnostic.config({
	virtual_text = false,
	signs = { text = { '', '', '', '' } }, -- {"", "", ""}
	float = { border = 'rounded', suffix = '', source = true, focusable = true,
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

vim.cmd [[hi link @punctuation.bracket Red | hi link @constructor.lua Red]]
vim.cmd [[hi DiagnosticUnderlineError gui=underline | hi DiagnosticUnderlineWarn gui=underline | hi DiagnosticUnderlineInfo gui=underline | hi DiffDelete guifg=red]]
vim.cmd [[hi StatusLine guibg=none | hi TabLineFill guibg=none]]
vim.fn.sign_define('DapBreakpoint', { text=' ', texthl='Error', linehl='', numhl='' })
vim.fn.sign_define('DapStopped', { text='󰋇 ', texthl='HealthSuccess', linehl='Visual', numhl='' })

centerize = function(str) return (" "):rep(math.floor((vim.o.columns - str:len()) / 2)) .. str end
UF = function() return centerize(vim.fn.getline(vim.v.foldstart):gsub([[%-%- %{%{%{ %-%- ]], "")) end
vim.cmd [[au BufReadPost init.lua setl foldtext=v:lua.UF() | lua vim.api.nvim_buf_set_extmark(0, vim.api.nvim_create_namespace("wtf"), 0, 0, { virt_text = {{ centerize("-- [ [   INIT.LUA   ] ] --"), "Function"}} })]]

-- vim: fdm=marker fdls=-1 fdl=0 nonu nornu scl=no
