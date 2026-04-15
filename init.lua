
-- {{{ -- Settings

vim.loader.enable()
vim.g.did_install_default_menus = 1
vim.g.gruvbox_material_background = 'hard'
vim.g.python3_host_prog = '/usr/bin/python'
vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_float_style = 'blend'

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
		fillchars = { eob=' ', fold=' ', foldopen="", foldsep=" ", foldclose="" }
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
command('Calc', function() require("calc").toggle() end)
command('Stalk', function() require("stalk").stalk() end)
-- }}}

-- {{{ -- Mappings

vim.g.mapleader = " "
vim.g.maplocalleader = ","
local function map(mode, key, func) vim.keymap.set(mode, key, func, {silent=true}) end
local function cmd(s) return "<CMD>"..s.."<CR>" end

-- Java DAP setup
map('n', '<leader>jt', cmd 'JavaTestDebugCurrentClass')
map('n', '<leader>jm', cmd 'JavaTestDebugCurrentMethod')
map('n', '<leader>jr', cmd 'JavaTestViewLastReport')
map('n', '<leader>db', cmd 'Dbee')

map('n', '<M-Enter>', cmd 'DapToggleBreakpoint')
map('n', '<Right>', cmd 'DapContinue')
map('n', '<Down>', cmd 'DapStepOver')
-- map('n', '<leader>do', function() require("dapui").toggle() end)
map('n', '<leader>do', cmd 'DapViewToggle!')
map('v', '<Cr>', function() require("dap.ui.widgets").hover() end)
-- map('v', '<Cr>', require("dapui").eval())

--> Test mappings

-- vim.keymap.set('n', '-', cmd 'Oil')

map('n', '<leader>d', vim.diagnostic.setqflist)
map('n', '<leader>c', function() require("essentials").konsole() end)
-- map('n', '<leader>u', function() require("thunder").run() end)
-- map('n', 'gQ', function() require("essentials").open_quick_note() end)
-- map('n', 'gQ', cmd 'vsp | Oil ~/Notes/')
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
map('n', '<leader>gt', function() vim.cmd("Diffview".. (next(require('diffview.lib').views) == nil and "Open" or "Close")) end)

map('n', '<C-n>', cmd "cnext")
map('n', '<C-p>', cmd "cprev")

--> Temp and Test maps
-- map('n', '<leader>l', function() require("essentials").toggle_term("lazygit", 't', true) end)
map('n', '<leader>l', cmd "tabnew | term lazygit")
map({'n', 't'}, '<C-t>', function() require("essentials").toggle_term("fish", 'v', true) end)
map('n', '<leader>p', cmd 'Lazy')
map('t', '<Esc><Esc>', [[<C-\><C-n>]])
map('n', 'gh', function() vim.cmd.help(vim.fn.expand('<cword>')) end)

--> General Mappings
map('n', '<leader>e', function() require("fyler").toggle({ kind = "split_left" }) end)
map('n', '<leader>q'   , function() require("essentials").toggle_quickfix() end)
map('n', '<leader>z'   , cmd 'NoNeckPain')

--> stuff.nvim keymaps (https://github.com/tamton-aquib/stuff.nvim)
map('n', 'gs', function() require("scratch").toggle() end)
map('n', 'gB', function() require("bt").toggle() end)
map('n', 'gT', function() require("tmpclone").clone() end)
map('n', 'gp', function() require("mpv").toggle_player() end)

--> Lsp mappings
map('n', 'gD', vim.lsp.buf.definition)
map('n', 'gd', '<cmd>vs | lua vim.lsp.buf.definition()<CR>')

--> essentials.nvim mappings ( https://github.com/tamton-aquib/essentials.nvim )
map('n', '<leader>r' , function() require("essentials").run_file() end)
map('n', '<leader>s' , function() require("essentials").swap_bool() end)
map('n', '<leader>w', Util.close_command)
map('n', 'gx', function() require("essentials").go_to_url() end)

--> WINDOW Control
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
map("n", "<leader>ff", function() Snacks.picker.files({ exclude=vim.opt.wildignore:get() }) end)
map("n", "<leader>fp", function() Snacks.picker.projects() end)
map("n", "<leader>fo", function() Snacks.picker.recent() end)
map("n", "<leader>fg", function() Snacks.picker.grep() end)
map("n", "<leader>fs", function() Snacks.picker.grep_word() end)
map("n", "<leader>fh", function() Snacks.picker.help() end)
map("n", "<leader>fr", function() Snacks.picker.resume() end)
map("n", "<leader>fd", function() Snacks.picker.lsp_workspace_symbols() end)
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
    appearance = { nerd_font_variant = 'normal' },
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
    scroll = { animate = { easing = "outQuart" }, filter  = function(buf) return vim.bo[buf].filetype ~= "json" and vim.bo[buf].buftype ~= "terminal" end },
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

-- local cfg_nvimtree = {
--     view = { preserve_window_proportions = true, adaptive_size = true },
--     update_focused_file = { enable = true, update_root = true },
--     renderer = { indent_markers = { enable = true } }
-- }


vim.g.lsp_status = ""
vim.g.mpv_visualizer = ""
vim.g.stl_macro_name = ""
local cfg_staline = function()
    vim.api.nvim_create_autocmd({"RecordingEnter"}, { callback = function() vim.g.stl_macro_name = " " .. vim.fn.reg_recording() end })
    vim.api.nvim_create_autocmd({"RecordingLeave"}, { callback = function() vim.g.stl_macro_name = "" end })
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
            local task_name = task.name
            if task_name == 'RUNNING' then res = res .. ' ' end
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
    -- { 'tamton-aquib/ads.nvim', config = true, dependencies = "3rd/image.nvim" },
{
  "ember-theme/nvim",
  name = "ember",
  priority = 1000,
  config = function()
    require("ember").setup({
      variant = "ember", -- "ember" | "ember-soft" | "ember-light"
    })
    vim.cmd("colorscheme ember")
  end,
},

    {
        "A7Lavinraj/fyler.nvim",
        config = function()
            -- vim.cmd [[au FileType fyler vert resize 30 | setl nonu nornu]]
            require("fyler").setup {
                integrations = { icon = "nvim_web_devicons" },
                views = {
                    finder = {
                        win = {
                            kind = "split_left",
                            kinds = { split_left = { width = "20%" },
                                win_opts = { signcolumn = "yes:1" }
                            }
                        },
                        default_explorer = true,
                        icon = { directory_collapsed = "  ", directory_empty = nil, directory_expanded = "  ", },
                    }
                }
            }
        end
    },

    { 'jedrzejboczar/possession.nvim', requires = { 'nvim-lua/plenary.nvim' }, opts = {} },
    { 'xzbdmw/colorful-menu.nvim', config = true },

    -- { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }, config = true },
    { "igorlfs/nvim-dap-view", opts = { winbar = { controls = { enabled = true } } } },

    -- { 'nvim-java/nvim-java', config = function()
    --     require("java").setup({
    --         jdk = { auto_install = false },
    --         jdtls = { version = "1.43.0" },
    --         -- java_debug_adapter = { enable = false, },
    --     })
    --     -- vim.lsp.config.jdtls = vim.tbl_extend("force", vim.lsp.config.jdtls or {}, {})
    --     -- vim.lsp.enable("jdtls")
    --     require("lspconfig").jdtls.setup({})
    --     -- vim.lsp.enable("jdtls")
    -- end,
    --     -- dependencies = { "neovim/nvim-lspconfig", "mason-org/mason.nvim" },
    -- },

  {
    "nvim-java/nvim-java",
    config = function()
      require("java").setup({ jdk = { auto_install = false }})

            -- vim.lsp.config.jdtls = vim.tbl_extend("force", vim.lsp.config.jdtls or {}, {
            -- cmd = { "jdtls", "-javaagent:/home/hi10143/Downloads/lombok.jar" },
            -- cmd_env = {
            --     JAVA_HOME="/usr/lib/jvm/java-21-openjdk-amd64/",
            -- }
            -- })
            vim.lsp.config("jdtls", {
                name = "jdtls",
                -- cmd = { "jdtls", "-javaagent:/home/hi10143/Downloads/lombok.jar", "-Xbootclasspath/a:/home/hi10143/Downloads/lombok.jar" },
                -- cmd = { "jdtls", "-javaagent:/home/hi10143/Downloads/lombok.jar" },
                cmd = { "jdtls", "--jvm-arg=-javaagent:/home/hi10143/Downloads/lombok.jar" },
                cmd_env = {
                    -- JAVA_HOME="/usr/lib/jvm/java-21-openjdk-amd64/",
                    JAVA_HOME="/usr/lib/jvm/java-21-openjdk-amd64/",
                    -- JDTLS_JVM_ARGS = "-javaagent:/home/hi10143/Downloads/lombok.jar"
                }
            })
            vim.lsp.enable("jdtls")
    end,
  },
    { 'mason-org/mason.nvim', opts = {} },
    -- { 'mason-org/mason.nvim', config = function() require("lspconfig").jdtls.setup({}) end },
    -- {
    --     "luckasRanarison/tailwind-tools.nvim",
    --     name = "tailwind-tools",
    --     build = ":UpdateRemotePlugins",
    --     opts = { conceal = { enabled = true } }
    -- },

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
    { "jake-stewart/auto-cmdheight.nvim", lazy = false, opts = { max_lines = 5, duration = 2, remove_on_key = true, clear_always = false, } },


    { "mistweaverco/kulala.nvim", ft = { "http", "rest" }, opts = cfg_kulala },
    -- { 'nvim-flutter/flutter-tools.nvim', dependencies = { 'nvim-lua/plenary.nvim' }, config = true },
    -- { "r-pletnev/pdfreader.nvim", dependencies = { "nvim-telescope/telescope.nvim" }, config = true },
    {
        "kndndrj/nvim-dbee",
        dependencies = { "MunifTanjim/nui.nvim" },
        build = function() require("dbee").install("cgo") end,
        config = function() require("dbee").setup() end,
    },
    -- { "pysan3/autosession.nvim", opts = { restore_on_setup = false }, event = { "VeryLazy" }, },
    -- { 'sindrets/diffview.nvim', config=true },
    {
        "dlyongemallo/diffview.nvim",
        version = "*",
    },
    -- { 'willothy/flatten.nvim', opts={window = { open="smart" } } },
    -- { 'stevearc/quicker.nvim', config=true },

    { 'stevearc/overseer.nvim', opts = {} },
    { 'nvim-treesitter/nvim-treesitter-context', config=function() require("treesitter-context").setup {enable=true} end, ft="json" },
    { "youyoumu/pretty-ts-errors.nvim", config = true },
    { "supermaven-inc/supermaven-nvim", config = true },
    { "folke/snacks.nvim", priority = 1000, opts = cfg_snacks },

    -- { 'stevearc/oil.nvim', opts={ float = { override = function(conf) conf.zindex = 69 return conf end } } },
    { 'danymat/neogen', config=true },
    { 'tiagovla/scope.nvim', config=true },
    { 'dmmulroy/tsc.nvim', opts={ enable_progress_notifications = true } },
    { 'windwp/nvim-ts-autotag', opts={} },

    --> My Useless lil plugins
    -- { 'tamton-aquib/staline.nvim', config=cfg_staline, event="ColorScheme", dev=true },
    { 'tamton-aquib/staline.nvim', config=function() require("staline").setup {
	sections = {
		left = {
			' ', 'right_sep_double', '-mode', 'left_sep_double', ' ',
			'right_sep', '-file_name', 'left_sep', ' ',
		},
		mid  = {'lsp'},
		right= {
			-- 'right_sep', '- ', '-lsp_name', '- ', 'left_sep', ' ',
			'right_sep', '-branch', 'left_sep', ' ',
			'right_sep_double', '-line_column', 'left_sep_double', ' ',
		}
	},

	defaults={
		fg = "#d4be98",
		-- cool_symbol = "  ",
		left_separator = "",
		right_separator = "",
		-- line_column = "%l:%c [%L]",
		true_colors = true,
		line_column = "[%l:%c] 󰍜 %p%% "
		-- font_active = "bold"
	},
	mode_colors = {
		n  = "#504945",
		i  = "#504945",
		ic = "#504945",
		c  = "#504945",
		v  = "#504945"       -- etc
	},
        mode_icons = {
            n  = " ",
        }
    }

    require("stabline").setup({ font_active="none", stab_start="  %#Identifier#  ", stab_bg='none', stab_left='', inactive_fg='none', fg="#95c561" })
    end, event="ColorScheme", dev=true },
    { 'tamton-aquib/stuff.nvim', lazy = true },
    { 'tamton-aquib/essentials.nvim', lazy = true },
    -- { 'tamton-aquib/flirt.nvim', opts={ speed=99, exclude_fts={ 'oil_preview', 'blink-cmp-documentation', 'snacks_picker_input' } }, cond=not vim.g.neovide },
    { 'tamton-aquib/mpv.nvim', opts={setup_widgets=true}, lazy=true }, --, dev=true },
    -- { 'tamton-aquib/nvim-market', import="nvim-market.plugins", config=true, lazy=true, dev=true },
    -- { 'tamton-aquib/duck.nvim', config=true },
    -- { 'tamton-aquib/keys.nvim', opts={} },
    -- { 'tamton-aquib/zone.nvim', opts={after=5, style='dvd'}, dev=true },

    --> THEMES AND UI
    { 'sainnhe/gruvbox-material', config = function() vim.cmd.colorscheme("gruvbox-material") end },
    { 'nvim-tree/nvim-web-devicons', opts={}, event="VeryLazy" },
    { 'norcalli/nvim-colorizer.lua', cmd="ColorizerToggle" },
    { 'lewis6991/gitsigns.nvim', config=true },
    -- { 'nvim-tree/nvim-tree.lua', opts=cfg_nvimtree, lazy=false },

    --> LSP and COMPLETION
    { 'neovim/nvim-lspconfig', config = cfg_lsp },
    { 'saghen/blink.cmp', opts = cfg_blink, opts_extend = { "sources.default" } },

    --> Telescope, TREESITTER, NEORG, REST
    { 'nvim-treesitter/nvim-treesitter', opts={highlight={enable=true}, indent={enable=true} }, main="nvim-treesitter.configs" },
    { "vhyrro/luarocks.nvim", opts={rocks={"magick"}} },
    { "nvim-neorg/neorg", ft="norg", dependencies={ "luarocks.nvim" }, opts=cfg_neorg },

    --> GENERAL PURPOSE
    { 'notjedi/nvim-rooter.lua', config=true },
    -- { 'nvim-focus/focus.nvim', opts = { excluded_windows = { 'fyler', 'NvimTree', 'dbui', 'dbee', 'no-neck-pain', 'DiffviewFiles' } } },
    -- { 'nvim-focus/focus.nvim', opts = { ui = { signcolumn = false }, excluded_windows = { 'Fyler', 'NvimTree', 'dbui', 'dbee', 'no-neck-pain', 'DiffviewFiles' } } },
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

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('disable-focus-autoresize', {}),
    callback = function(_) if vim.tbl_contains({ 'dapui_scopes', 'fyler' }, vim.bo.ft) then vim.b.focus_disable = true end end,
})
-- vim.cmd("au TermOpen * set winhl=Normal:TermNormal,NormalNC:TermNormal | hi TermNormal guibg=#151515 guifg=#deddda")

--> Custom Highlights
vim.cmd [[hi link @punctuation.bracket Red | hi link @constructor.lua Red]]
vim.cmd [[hi WarningText gui=underline | hi ErrorText gui=underline | hi TSDanger gui=reverse]]
vim.cmd [[hi StatusLine guibg=none | hi TabLineFill guibg=none]]
vim.cmd [[hi! Normal guibg=none | hi NormalNC guibg=none]]
-- vim.defer_fn(function() vim.cmd [[hi! BlinkCmpMenu guibg=none | hi! BlinkCmpMenuBorder guibg=none]] end, 500)
vim.fn.sign_define('DapBreakpoint', { text=' ', texthl='Error', linehl='', numhl='' })
vim.fn.sign_define('DapStopped', { text='󰋇 ', texthl='HealthSuccess', linehl='Visual', numhl='' })

function UF()
    local title = vim.fn.getline(vim.v.foldstart):gsub([[%-%- %{%{%{ %-%- ]], "")
    return (" "):rep(math.floor((vim.o.columns - title:len()) / 2)) .. title
end

vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = vim.fn.stdpath("config") .. "/init.lua",
    once = true,
    callback = function()
        vim.cmd [[setl foldtext=v:lua.UF()]]
        vim.keymap.set('n', '<CR>', 'za', {buffer=0})
        vim.api.nvim_buf_set_extmark(0, vim.api.nvim_create_namespace("wtf"), 0, 0, {
            virt_text = {{ Util.center({"-- [[ INIT.LUA ]] --"})[1] , "Function"}}
        })
    end
})

-- require('vim._core.ui2').enable({
--   enable = true,
--   msg = {
--     targets = {
--       [''] = 'msg',
--       empty = 'cmd',
--       bufwrite = 'msg',
--       confirm = 'cmd',
--       emsg = 'pager',
--       echo = 'msg',
--       echomsg = 'msg',
--       echoerr = 'pager',
--       completion = 'cmd',
--       list_cmd = 'pager',
--       lua_error = 'pager',
--       lua_print = 'msg',
--       progress = 'pager',
--       rpc_error = 'pager',
--       quickfix = 'msg',
--       search_cmd = 'cmd',
--       search_count = 'cmd',
--       shell_cmd = 'pager',
--       shell_err = 'pager',
--       shell_out = 'pager',
--       shell_ret = 'msg',
--       undo = 'msg',
--       verbose = 'pager',
--       wildlist = 'cmd',
--       wmsg = 'msg',
--       typed_cmd = 'cmd',
--     },
--     cmd = {
--       height = 0.5,
--     },
--     dialog = {
--       height = 0.5,
--     },
--     msg = {
--       height = 0.3,
--       timeout = 5000,
--     },
--     pager = {
--       height = 0.5,
--     },
--   },
-- })


-- vim: fdm=marker fdls=-1 fdl=0 nonu nornu scl=no
