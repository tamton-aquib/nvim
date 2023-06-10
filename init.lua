


-- {{{ -- Settings

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    print("Installing lazy.nvim...")
    vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim", lazypath})
end
vim.opt.rtp:prepend(lazypath)

local opts = {
    General = {
        exrc = true, spell = false, wrap = false, linebreak = true, ruler = false, conceallevel = 2,
        showcmd = false, hlsearch = false, timeoutlen = 300, updatetime = 300, swapfile = false,
        wildignore = { '*.pyc,__pycache__,node_modules,*.lock' },
    },
    Backup = {
        backup = false, writebackup = false
    },
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
        pumblend = 20, inccommand = "split", termguicolors = true, number = true, signcolumn = "yes:1",
        rnu = true, guifont = "JetBrainsMonoNerdFontComplete Nerd Font", shortmess = "tF".."TIcC".."as".."WoO",
        fillchars = { eob=' ', fold=' ', foldopen="", foldsep=" ", foldclose="" }
    },
    Tabspace = {
        shiftwidth = 4, tabstop = 4, softtabstop = 0, expandtab = true,
        smartindent = true, breakindent = true, smarttab = true
    }
}

--> Apply the options
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
local fn = vim.fn
local api = vim.api

function Tabline()
    local res = vim.iter(vim.api.nvim_list_bufs()):map(function(buf)
        local filename = vim.api.nvim_buf_get_name(buf)
        local ext = vim.fn.fnamemodify(filename, ":p:e")
        local name = vim.fn.fnamemodify(filename, ":p:t")
        local icon, hl = require("nvim-web-devicons").get_icon(name, ext, {default=true})
        return (vim.api.nvim_buf_is_loaded(buf) and not vim.tbl_contains({"TelescopePrompt"}, vim.bo[buf].ft) and filename ~= "" and vim.bo[buf].buflisted) and
            "%#Normal#  " ..
            "%#".. hl .. "#"..
            icon .. " " ..
            (vim.api.nvim_get_current_buf() == buf and "%#Function#" or "%#Normal#")..
            " "..vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":p:t").." "..(vim.bo[buf].modified and "" or " ")..
            "%#Normal# "
        or ""
    end)
    return "%#Normal#   " .. table.concat(res:totable())
end
Util.tab_line = function() vim.opt.tabline = '%!v:lua.Tabline()' end

Util.status_line = function()
    vim.g.gitsigns_head = "" vim.g.mode_text = ""
    vim.cmd [[hi link NiceHighlight String]]
    vim.api.nvim_create_autocmd("ModeChanged", { callback = function()
        local mode = vim.api.nvim_get_mode().mode
        local color = ({ n="String", i="Keyword", c="Identifier", v="Type", r="Statement", V="Type"})[mode] or "None"
        vim.g.mode_text = ({ n="", i="", c=" ", t=" ", v="", r="﯒", V="", [""]="" })[mode] or "nil?"
        vim.cmd("hi link NiceHighlight "..color)
    end })
    vim.opt.statusline = "%#Normal#   %#NiceHighlight#%{g:mode_text}     %{g:gitsigns_head} %= %t %= [%l/%L] :%c       "
end

Util.mess = function()
    local contents = vim.api.nvim_exec("mess", true)
    if contents == "" then return end
    vim.cmd("vnew | setl bt=nofile bh=wipe nonu nornu")

    vim.api.nvim_put(vim.split(contents, '\n'), "", true, true)
    require("essentials.utils").set_quit_maps()
end

--> Simple dashboard
Util.splash_screen = function()
    local xdg = vim.fn.fnamemodify(vim.fn.stdpath("config"), ":h").."/"
    local arg = vim.fn.argv(0)
    if arg and (vim.fn.isdirectory(arg) ~= 0) or arg == ""  then
        vim.api.nvim_buf_set_option(0, 'bufhidden', 'wipe')

        local GUICURSOR = vim.opt.guicursor:get()
        vim.schedule(function()
            local buf = vim.api.nvim_create_buf(false, true)
            local map = function(lhs, rhs) vim.keymap.set('n', lhs, rhs, {silent=true, buffer=0}) end
            local keys = {K='kitty/kitty.conf', W='wezterm/wezterm.lua', I='nvim/init.lua', A='alacritty/alacritty.yml', F='fish/config.fish'}
            vim.api.nvim_win_set_buf(0, buf)
            vim.api.nvim_put(vim.split((" , "):rep(vim.o.lines), ","), "l", true, true)
            vim.cmd [[set guicursor=n:block-Normal]]
            vim.cmd [[silent! setl nonu nornu ft=dashboard]]

            for k,f in pairs(keys) do map(k,'<cmd>e '..xdg..f..' | setl noacd<CR>') end
            map('P', '<cmd>Telescope oldfiles<CR>')
            map('q', '<cmd>q<CR>')
            map('o', '<cmd>e #<1<CR>') -- last edited file

            local image = require('hologram.image'):new("/Users/tamtonaquib/Downloads/crown_colorized.png", {})
            image:display( math.floor(vim.o.lines/2)+7, math.floor(vim.o.columns/2 - 18), vim.api.nvim_get_current_buf(), {})
            vim.api.nvim_create_autocmd({"BufEnter"}, {
                once=true,
                callback=function()
                    vim.opt.guicursor=GUICURSOR
                    image:delete(0, {free=true})
                end
            })
        end)
    end
end

--> Closing Windows and buffers
Util.close_command = function()
    if vim.bo.modified then print("buf not saved!") return end
    local total = #vim.tbl_filter(function(buf)
        return vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_name(buf) ~= ""
    end, vim.api.nvim_list_bufs())

    local quit_cmd = #vim.api.nvim_list_wins() > 1 and 'Q' or 'q'
    vim.cmd(total == 1 and quit_cmd or 'bd')
end

--> Different Kinds of Borders
Util.border = ({{ "╒", "═", "╕", "│", "╛", "═", "╘", "│" }, { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" }})[2]

--> Custom telescope theme
Util.telescope_theme = {
    results_title = false,
    preview_title = false,
    prompt_title = false,
    layout_strategy = "center",
    sorting_strategy = "ascending",
    prompt_prefix = "      ",
    winblend = 30,
    layout_config = { preview_cutoff=1, width = 0.7, height = 0.7 },
    borderchars = {
        preview = { "▔", "▕", "▁", "▏", "🭽", "🭾", "🭿", "🭼" },
        prompt = { "▔", "▕", "▁", "▏", "🭽", "🭾", "🭿", "🭼" },
        results = { "▁", " ", " ", " ", "🭼", "🭿", " ", " " },
    },
}

--> Toggling quickfix window with a keybind
Util.toggle_quickfix = function()
    vim.cmd(#vim.tbl_filter(function(w) return fn.win_gettype(w) == "quickfix" end, api.nvim_list_wins()) > 0 and "ccl" or "cope")
end

-- }}}

-- {{{ -- Autocmds

--> Wrapper funcs
local command = function(name, func, desc) vim.api.nvim_create_user_command(name, func, {desc=desc}) end
local au = function(events, ptn, cb) vim.api.nvim_create_autocmd(events, {pattern=ptn, [type(cb)=="function" and 'callback' or 'command']=cb}) end

-->  NEW
au("LspAttach", "*", function(a) vim.lsp.get_client_by_id(a.data.client_id).server_capabilities.semanticTokensProvider=nil end)
-- au("FileType", "norg", "setl nonu nornu signcolumn=yes:4")
au({"BufReadPost", "FileType"}, "javascript", "setl ts=2 sw=2")

-->  LSP Related
-- au("BufWritePre", "*.js,*.jsx,*.ts,*.tsx", function() vim.lsp.buf.format() end)
au("BufWritePre", "*.rs,*.svelte", function() vim.lsp.buf.format() end)
au("CursorHold", "*", vim.diagnostic.open_float)

-->  OLD
au("FileType", "json", function() vim.opt_local.cole=0 end)
au("BufReadPost", "*.lua", [[call matchadd("Keyword", "--> \\zs.*\\ze$")]])
-- au("FileType", "markdown", function() vim.opt_local.spell=true end)
au("BufEnter", "*", 'setl fo-=cro')
au("BufReadPost", "*", function() require("essentials").last_place() end)
au("TextYankPost", "*", function() vim.highlight.on_yank({higroup="Visual", timeout=200}) end)
au("TermOpen", "term://*", "setl nonu nornu | star")

-->  Commands
command("Format", vim.lsp.buf.format, "Formats the current buffer.")
command("X", ":silent !xset r rate 169 69", "Keyboards press-release rate.")
command("PP", function() require("essentials").null_pointer() end, {range='%'})
command("Mess", Util.mess, "Message to temp output buf.")
-- vim.cmd [[syntax keyword Keyword lambda conceal cchar=λ]] -- TODO: (maybe with ts queries?)

-- }}}

-- {{{ -- Mappings

vim.g.mapleader = " "
vim.g.maplocalleader = ","
local function map(mode, key, func) vim.keymap.set(mode, key, func, {silent=true}) end
local function cmd(s) return "<CMD>"..s.."<CR>" end

map('c', 'jk', '<C-f><cmd>resize -20<cr>')
map('n', '<leader>hn', cmd "Gitsigns next_hunk")
map('n', '<leader>hp', cmd "Gitsigns prev_hunk")
map('n', 'gpd', function() require("goto-preview").goto_preview_definition({}) end)

map('n', '<C-n>', cmd "cnext")
map('n', '<C-p>', cmd "cprev")

--> TEMP and TEST maps
map('n', '<leader>l', function() require("essentials").toggle_term("lazygit", 't', true) end)
map('n', '<leader>t', function() require("essentials").toggle_term("fish", 'v', true) end)
map('n', '<leader>p', cmd 'Lazy')
map('n', '<leader>ca', vim.lsp.buf.code_action)
map('t', '<C-n>', [[<C-\><C-n>]]) -- :sadkek:
map('n', 'gh', function() vim.cmd(":h "..vim.fn.expand('<cword>')) end)

--> General Mappings
map('n', '<leader>dd'  , function() require("duck").hatch() end)
map('n', '<leader>dk'  , function() require("duck").cook() end)
map('n', '<leader>e'   , function() require("nvim-tree.api").tree.toggle() end)
map('n', '<leader>n'   , cmd 'Neogen')
map('n', '<leader>q'   , Util.toggle_quickfix)
map('n', '<leader>z'   , cmd 'FocusMaximise')

--> stuff.nvim maps (https://github.com/tamton-aquib/stuff.nvim)
map('n', '<leader>ii', function() require("lazyn").install_picker() end)
map('n', '<leader>iu', function() require("lazyn").remove_picker() end)
map('n', '<leader>cc', function() require("chatgpt").chatgpt() end)
map('n', 'gC', function() require("calc").toggle() end)
map('n', 'gS', function() require("stalk").stalk() end)
map('n', 'gs', function() require("scratch").toggle() end)
map('n', 'gB', function() require("bt").toggle() end)
map('n', 'gT', function() require("tmpclone").clone() end)
map('n', 'gp', function() require("mpv").toggle_player() end)

--> Lsp mappings
map('n', 'gd',    vim.lsp.buf.definition)
map('n', 'gD',    vim.lsp.buf.declaration)
map('n', 'gr',    vim.lsp.buf.references)
map('n', 'gi',    vim.lsp.buf.implementation)
map('n', 'K',     vim.lsp.buf.hover)
map('n', '<M-n>', vim.diagnostic.goto_next)
map('n', '<M-p>', vim.diagnostic.goto_prev)

--> essentials.nvim mappings ( https://github.com/tamton-aquib/essentials.nvim )
map('v', '<leader>/' , ':lua require("essentials").toggle_comment(true)<CR>')
map('n', '<leader>/' , ':lua require("essentials").toggle_comment()<CR>')
map('n', '<F2>'      , function() require("essentials").rename() end)
map('n', '<leader>r' , function() require("essentials").run_file() end)
map('n', '<leader>s' , function() require("essentials").swap_bool() end)
map('n', '<leader>w' , Util.close_command)
map('n', 'gx'        , function() require("essentials").go_to_url("open") end)
map('n', '<leader>cs', function() require("essentials").cheat_sh() end)

--> Telescope mappings
map('n', '<leader>ff', function() require("telescope.builtin").find_files(Util.telescope_theme) end)
map('n', '<leader>fg', function() require("telescope.builtin").live_grep(Util.telescope_theme) end)
map('n', '<leader>fs', function() require("telescope.builtin").grep_string(Util.telescope_theme) end)
map('n', '<leader>fh', function() require("telescope.builtin").help_tags(Util.telescope_theme) end)
map('n', '<leader>fo', function() require("telescope.builtin").oldfiles(Util.telescope_theme) end)
map('n', '<leader>fc', '<cmd>Telescope commands theme=ivy<CR>')

--> WINDOW Control
map('n', '<C-h>'    , '<C-w>h')
map('n', '<C-j>'    , '<C-w>j')
map('n', '<C-k>'    , '<C-w>k')
map('n', '<C-l>'    , '<C-w>l')
map('n', '<A-Down>', '<C-w>-')
map('n', '<A-Up>', '<C-w>+')

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
local cfg_retrobox = function(_)
    -- vim.cmd(os.date("%H") >= 18 and 'retrobox' or 'peachpuff')
    vim.cmd.colorscheme("retrobox")
    vim.cmd [[
        hi link GitSignsAdd String
        hi link GitSignsChange Identifier
        hi link GitSignsDelete Keyword
        hi Function gui=italic
        hi link FloatBorder NormalFloat
    ]]
end

local cfg_cmp = function()
    local cmp = require('cmp')
    local luasnip = require("luasnip")

    -- local source_names = { nvim_lsp = "[LSP]", emoji = "[Emoji]", path = "[Path]", luasnip = "[Snippet]", buffer = "[Buffer]", nvim_lsp_signature_help = "[sig_help]" }
    local kind_icons = {
        Text = ' ', Method = ' ', Function = ' ', Constructor = ' ', Field = ' ', Variable = ' ', Class = ' ', Interface = ' ',
        Module = ' ', Property = ' ', Unit = ' ', Value = ' ', Enum = ' ', Keyword = ' ', Snippet = ' ', Color = ' ', File = ' ',
        Reference = ' ', Folder = ' ', EnumMember = ' ', Constant = ' ', Struct = ' ', Event = ' ', Operator = ' ', TypeParameter = ' ',
    }
    for _, k in ipairs(vim.tbl_keys(kind_icons)) do vim.cmd("hi CmpItemKind"..k.." gui=reverse") end

    cmp.setup {
        formatting = {
            fields = { 'kind', 'abbr', 'menu' },
            format = function(_, item)
                item.kind = (' '..kind_icons[item.kind]) or " "
                -- item.menu = source_names[entry.source.name] or " "
                return item
            end
        },
        window = { documentation = { border = "shadow" }, completion={side_padding=0} },
        snippet = { expand=function(o) luasnip.lsp_expand(o.body) end },

        mapping = cmp.mapping.preset.insert {
            ['<C-b>'] = cmp.mapping.scroll_docs(-1),
            ['<C-f>'] = cmp.mapping.scroll_docs(1),
            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ['<Tab>'] = function(fallback) (luasnip.jumpable() and luasnip.jump or fallback)() end
        },

        sources = cmp.config.sources {
            { name = 'path' },
            { name = 'nvim_lsp' },
            { name = 'nvim_diagnostic' },
            { name = 'buffer'},
            { name = 'nvim_lsp_signature_help' },
            { name = 'nvim_lua' },
            { name = 'luasnip' },
            { name = 'emoji'},
            { name = 'neorg'},
            { name = 'crates'},
        },

        experimental = { ghost_text = true }
    }

    cmp.setup.cmdline(':', { mapping=cmp.mapping.preset.cmdline(), sources={{name="cmdline", keyword_length=3}} })
end

local cfg_luasnip = function()
    local ls = require('luasnip')
    ls.config.set_config({ region_check_events = "InsertEnter", delete_check_events = "InsertLeave" })
    local parse = ls.parser.parse_snippet

	local snips = {
		lua = 'vim.print(${0})',
		python = 'print("${0}")',
		rust = 'println!("${0}");',
		c = 'printf("${0}");', cpp = 'std::cout << "${0}" << std::endl;',
		javascript = 'console.log("${0}");', typescript = 'console.log("${0}");',
	}

    local t = {}
    for lang, snip in pairs(snips) do t[lang] = {parse({trig="pp", wordTrig=true}, snip)} end
    ls.add_snippets(nil, t)
end

local cfg_telescope = {
    defaults = {
        sorting_strategy = "ascending", layout_config = { prompt_position = "top" },
        file_ignore_patterns = {'__pycache__/', 'node_modules/', '%.lock', 'target/', '__pypackages__/'},
    }
}

local cfg_neorg = {
    load = {
        ["core.defaults"] = {},
        ["core.completion"] = { config={ engine="nvim-cmp" } },
        ["core.concealer"] = { config={ dim_code_blocks={conceal=false} } },
        ["core.presenter"] = { config={ zen_mode = "zen-mode" } },
        ["core.itero"] = {},
        ["external.exec"] = {},
        ["core.ui.calendar"] = {}
    }
}

local cfg_treesitter = function()
    require('nvim-treesitter.configs').setup {
        ensure_installed = { "comment", "lua", "python" },
        highlight = { enable = true },
        indent = { enable = true }, -- TODO: try text objects somewhen
    }
end

-- }}}

-- {{{ -- Lazy
local path = vim.fn.stdpath("config") .. "/plugins.json"

local real_plugins = {
    -->  Temporary and testing
    { 'edluffy/hologram.nvim', config=true, lazy=true },
    { 'rmagatti/goto-preview', opts={border=Util.border} },
    -- { 'Saecki/crates.nvim', event={'BufRead Cargo.toml'}, config=true },
    -- { 'kylechui/nvim-surround', config=true }

    -->  My Useless lil plugins
    { 'tamton-aquib/flirt.nvim', config=true },
    { 'tamton-aquib/stuff.nvim' },
    { 'tamton-aquib/essentials.nvim', lazy=true },

    -->  THEMES AND UI
    { 'nvim-tree/nvim-web-devicons', config=true, lazy=true },
    { 'norcalli/nvim-colorizer.lua', cmd="ColorizerToggle" },
    { 'lewis6991/gitsigns.nvim', config=true, event='BufReadPost' },
    { 'nvim-tree/nvim-tree.lua', opts={ renderer={ indent_markers={ enable=true } } }, lazy=true },
    { 'declancm/cinnamon.nvim', config=true, keys={'<C-u>', '<C-d>'} },

    -->  LSP and COMPLETION
    { 'neovim/nvim-lspconfig' },
    { 'L3MON4D3/LuaSnip', config=cfg_luasnip, event="InsertEnter", lazy=true },
    { 'hrsh7th/nvim-cmp', config=cfg_cmp, event={"InsertEnter", "CmdlineEnter"}, lazy=true,
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lua',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-cmdline'
        }
    },

    -->  TELESCOPE, TREESITTER, NEORG
    { 'nvim-lua/plenary.nvim', lazy=true },
    { 'nvim-telescope/telescope.nvim', config=cfg_telescope, lazy=true, cmd="Telescope" },
    { 'nvim-treesitter/nvim-treesitter', config=cfg_treesitter, lazy=true },
    { 'nvim-neorg/neorg', ft="norg", opts=cfg_neorg, dependencies={"laher/neorg-exec"} },

    -->  GENERAL PURPOSE
    { 'danymat/neogen', opts={snippet_engine="luasnip"}, cmd="Neogen" },
    { 'notjedi/nvim-rooter.lua', config=true },
    { 'beauwilliams/focus.nvim', opts={cursorline=false}, event="WinNew" },
    { 'windwp/nvim-autopairs', config=true, event="InsertEnter" },
    { 'lukas-reineke/indent-blankline.nvim', opts={show_current_context=true, char='▏' } },
}

local installer_plugins = vim.tbl_map(function(p)
    return {p.url:gsub("https://github.com/", ""), config=p.config}
end, vim.json.decode(table.concat(vim.fn.readfile(path))))

local bruh = vim.list_extend(real_plugins, installer_plugins)
require("lazy").setup(bruh, {
    install={colorscheme={"retrobox"}},
    performance = { rtp = { disabled_plugins = {
    "python3_provider", "node_provider", "2html_plugin", "getscript", "getscriptPlugin",
    "gzip", "matchit", "tar", "tarPlugin", "rrhelper", "spellfile_plugin", "vimball",
    "vimballPlugin", "zip", "zipPlugin", "tutor", "rplugin", "spellfile", "tarPlugin",
    "man", "logiPat", "netrwSettings", "netrwFileHandlers", "remote_plugins", "netrw"
    }}
}})
-- }}}

-- {{{ -- LSP

local border = Util.border

local signs = { Error = "", Warn  = "", Hint  = "", Info  = "", other = "﫠" }

for name, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. name
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

vim.lsp.handlers["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = border})
vim.lsp.handlers["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = border})

vim.diagnostic.config({
    virtual_text = false,
    underline = { Error=true },
    float = {
        border = border, focusable = false, suffix = '',
        header = { "  Diagnostics", "String" },
        prefix = function(_, _, _) return "  " , "String" end, -- icons:        ﬌  
    }
})

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

local s = {
    pyright={},
    tsserver={},
    cssls={},
    -- rust_analyzer={},
    -- ruff_lsp={},
    lua_ls = {
        settings = {
            Lua = {
                diagnostics={globals={'vim'}},
                runtime={version="LuaJIT"},
                path=runtime_path,
                workspace = { library = vim.api.nvim_get_runtime_file('', true), checkThirdParty=false },
            }
        }
    }
}

for server, opt in pairs(s) do
    opt.capabilities = capabilities
    lspconfig[server].setup(opt)
end
-- }}}

-- {{{ -- MISC
Util .splash_screen()
cfg_retrobox(true)
Util .status_line()
Util .tab_line()

function UnusualFolds()
    local title = vim.fn.getline(vim.v.foldstart):gsub([[%-%- %{%{%{ %-%- ]], "")
    local spaces = (" "):rep(math.floor(vim.o.columns - title:len()) / 2)

    return spaces .. title
end

vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "init.lua",
    callback = function()
        vim.cmd [[setl fdm=marker fdls=-1 fdl=0 nonu nornu signcolumn=yes:2]]
        vim.opt.foldtext = 'v:lua.UnusualFolds()'
        local main_text = "-- [[ Noice ]] --"
        vim.api.nvim_buf_set_extmark(0, vim.api.nvim_create_namespace("taj0023"), 0, 0, {
            virt_text = {{
                (" "):rep(math.floor(vim.o.columns - main_text:len()) / 2 - 1) .. main_text
            , "Function"}}
        })
    end
})
-- }}}
