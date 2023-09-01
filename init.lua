


-- {{{ -- Settings

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    print("Installing lazy.nvim...")
    vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim", lazypath})
end
vim.opt.rtp:append(lazypath)

local opts = {
    General = {
        exrc = true, spell = false, wrap = false, linebreak = true, ruler = false, conceallevel = 2,
        hlsearch = false, timeoutlen = 300, updatetime = 500, swapfile = false,
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
        pumblend = 20, inccommand = "split", termguicolors = true, number = true, signcolumn = "yes:2",
        rnu = true, guifont = "Rec Mono Casual:h7", shortmess = "tF".."TIcC".."as".."WoO",
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

Util.mess = function()
    local contents = vim.api.nvim_exec2("mess", {output=true})
    if contents.output == "" then return end
    vim.cmd("vnew | setl bt=nofile ft=yaml bh=wipe nonu nornu")

    vim.api.nvim_put(vim.split(contents.output, '\n'), "", true, true)
    require("essentials.utils").set_quit_maps()
end

--> Open current project note neorg file.
Util.open_quick_note = function()
    local datapath = vim.fn.stdpath("data").."/quicknote/"
    if not vim.uv.fs_stat(datapath) then
        vim.notify("Datapath doesnt exist. Creating....")
        vim.fn.mkdir(datapath)
    end

    ---@diagnostic disable-next-line: undefined-field
    local project_name = vim.fn.fnamemodify(vim.uv.cwd(), ":t"):gsub("[\\.\\-]", "")
    vim.cmd.edit(datapath..project_name..'.norg')
end

--> Simple dashboard
Util.splash_screen = function()
    local xdg = vim.fn.fnamemodify(vim.fn.stdpath("config"), ":h").."/"
    local arg = vim.fn.argv(0)
    if arg and (vim.fn.isdirectory(arg) ~= 0) or arg == "" and vim.bo.ft ~= "lazy"  then
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

            local image = require('hologram.image'):new(vim.fn.expand("~/Downloads/crown_colorized.png"), {})
            image:display( math.floor(vim.o.lines/2), math.floor(vim.o.columns/4+5), vim.api.nvim_get_current_buf(), {})
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
Util.border = ({{ "╒", "═", "╕", "│", "╛", "═", "╘", "│" }, { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" }})[1]
-- Util.border = "shadow"

--> Toggling quickfix window with a keybind
Util.toggle_quickfix = function()
    vim.cmd(#vim.iter(vim.api.nvim_list_wins()):filter(function(w) return vim.fn.win_gettype(w) == "quickfix" end):totable() > 0 and "ccl" or "cope")
end

Util.konsole = function()
    local word = vim.fn.expand("<cword>")
    local ans = ({
        javascript = 'console.log("'..word..': ", '..word..')',
        lua = 'vim.print("'..word..': ", '..word..')',
    })[vim.bo.ft]
    vim.api.nvim_buf_set_lines(0, vim.fn.line('.'), vim.fn.line('.'), false, {vim.api.nvim_get_current_line():match("^%s*")..ans})
end

-- }}}

-- {{{ -- Autocmds

--> Wrapper funcs
local command = function(name, func, desc) vim.api.nvim_create_user_command(name, func, {desc=desc}) end
local au = function(events, ptn, cb) vim.api.nvim_create_autocmd(events, {pattern=ptn, [type(cb)=="function" and 'callback' or 'command']=cb}) end

-->  NEW
au("LspAttach", "*", function(a) vim.lsp.get_client_by_id(a.data.client_id).server_capabilities.semanticTokensProvider=nil end)
-- au({"BufReadPost", "FileType"}, "javascript,css", "setl ts=2 sw=2")

-->  LSP Related
au("BufWritePre", "*.rs,*.svelte", function() vim.lsp.buf.format() end)
au("CursorHold", "*", vim.diagnostic.open_float)

-->  OLD
au("FileType", "json", function() vim.opt_local.cole=0 end)
au("BufReadPost", "*.lua", [[call matchadd("Keyword", "--> \\zs.*\\ze$")]])
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
---> Helper functions
local function map(mode, key, func) vim.keymap.set(mode, key, func, {silent=true}) end
local function cmd(s) return "<CMD>"..s.."<CR>" end

map('n', '<leader>dd', function() require("duck").hatch() end)
map('n', '<leader>k', Util.konsole)
map('n', 'K', vim.lsp.buf.hover)
map('n', 'gQ', Util.open_quick_note)

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
map('t', '<C-n>', [[<C-\><C-n>]]) -- :sadkek:
map('n', 'gh', function() vim.cmd(":h "..vim.fn.expand('<cword>')) end)

--> General Mappings
map('n', '<leader>e'   , function() require("nvim-tree.api").tree.toggle({find_file=true}) end)
map('n', '<leader>n'   , cmd 'Neogen')
map('n', '<leader>q'   , Util.toggle_quickfix)
map('n', '<leader>z'   , cmd 'FocusMaximise')

--> stuff.nvim maps (https://github.com/tamton-aquib/stuff.nvim)
map('n', '<leader>ii', function() require("nvim-market").install_picker() end)
map('n', '<leader>iu', function() require("nvim-market").remove_picker() end)
map('n', '<leader>cc', function() require("chatgpt").chatgpt() end)
map('n', 'gC', function() require("calc").toggle() end)
map('n', 'gS', function() require("stalk").stalk() end)
map('n', 'gs', function() require("scratch").toggle() end)
map('n', 'gB', function() require("bt").toggle() end)
map('n', 'gT', function() require("tmpclone").clone() end)
map('n', 'gp', function() require("mpv").toggle_player() end)

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
map('n', '<leader>w' , Util.close_command)
map('n', 'gx'        , function() require("essentials").go_to_url() end)
map('n', '<leader>cs', function() require("essentials").cheat_sh() end)

--> Telescope mappings
map('n', '<leader>ff', function() require("telescope.builtin").find_files() end)
-- map('n', '<leader>fg', function() require("telescope.builtin").live_grep(Util.telescope_theme) end)
map('n', '<leader>fg', function() require("telescope").extensions.egrepify.egrepify() end)
map('n', '<leader>fs', function() require("telescope.builtin").grep_string() end)
map('n', '<leader>fh', function() require("telescope.builtin").help_tags() end)
map('n', '<leader>fo', function() require("telescope.builtin").oldfiles() end)
map('n', '<leader>fc', '<cmd>Telescope commands theme=ivy<CR>')
-- map('n', '<leader>fp', '<cmd>Telescope projects theme=dropdown<CR>')

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
    local luasnip = require("luasnip")

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
                item.kind = (' '..kind_icons[item.kind]) or " "
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
            { name = 'nvim_lsp_signature_help' },
            { name = 'luasnip' },
            { name = 'buffer'},
            { name = 'nvim_lua' },
            { name = 'neorg'},
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

local cfg_telescope = function()
    require("telescope").setup {
    defaults = {
        prompt_prefix = "      ",
        mappings = { i = {["<C-y>"] = require("telescope.actions.layout").toggle_preview} },
        sorting_strategy = "ascending",
        layout_config = { prompt_position = "top" },
        file_ignore_patterns = {'__pycache__/', 'node_modules/', '%.lock', 'target/', '__pypackages__/'},
    } }
    -- require('telescope').load_extension('projects')
    require "telescope".load_extension('egrepify')
end


local cfg_neorg = {
    load = {
        ["core.defaults"] = {},
        ["core.completion"] = { config={ engine="nvim-cmp" } },
        ["core.concealer"] = { config={ dim_code_blocks={conceal=false} } },
        ["core.presenter"] = { config={ zen_mode = "zen-mode" } },
        ["core.itero"] = {},
        ["external.exec"] = {},
    }
}

local cfg_treesitter = function()
    require("nvim-treesitter.configs").setup {
        highlight = {enable=true}, indent = {enable=true}
    }
end

local cfg_staline = function()
    vim.cmd [[function Bruh(a,b,c,d)
        lua require("mpv").toggle_player()
    endfunction]]
    vim.g.lsp_status = ""
    vim.api.nvim_create_autocmd("LspProgress", {
        callback = function(nice)
            local sttaus = nice.data.result.value.percentage or ""
            vim.g.lsp_status = type(sttaus) == "number" and sttaus.."%" or ""
            vim.cmd.redrawstatus()
        end
    })

    vim.g.mpv_visualizer = ""
    require("staline").setup({
        defaults = { true_colors=true },
        sections={
            left = { '  ', 'mode', '  ', 'git_branch', '   ', 'lsp', '   %{g:lsp_status}' },
            right = { '  %10@Bruh@󰎆 %X %{g:mpv_visualizer}', 'line_column', '  ' }
        }
    })
    require("stabline").setup({
        stab_start="   ", stab_bg='none', stab_left='', fg='#b8bb26', inactive_fg='none'
    })
end

-- }}}

-- {{{ -- Lazy
local pluhs = {
    -->  Temporary and testing
    { 'willothy/flatten.nvim', lazy=false, config=true },
    { 'akinsho/toggleterm.nvim', opts={direction='float', auto_scroll=false} },
    { 'edluffy/hologram.nvim', config=true, lazy=true },
    { 'kylechui/nvim-surround', config=true },

    -->  My Useless lil plugins
    -- { 'tamton-aquib/zone.nvim', opts={after=1000} },
    -- { 'tamton-aquib/keys.nvim', config=true },
    { 'tamton-aquib/mpv.nvim', config={setup_widgets=true} },
    { dir='~/STUFF/NEOVIM/staline.nvim', config=cfg_staline, event="ColorScheme" },
    -- { dir='~/STUFF/NEOVIM/flirt.nvim', config=true },
    { dir='~/STUFF/NEOVIM/stuff.nvim', lazy=true },
    { 'tamton-aquib/nvim-market', import="nvim-market.plugins", config=true },
    { 'tamton-aquib/essentials.nvim', lazy=true },

    -->  THEMES AND UI
    -- { 'nvim-tree/nvim-web-devicons', opts={override={norg={icon=" ", color="#4878be", name="neorg"}} }, lazy=true },
    { 'DaikyXendo/nvim-web-devicons', opts={override={norg={icon=" ", color="#4878be", name="neorg"}} }, lazy=true },
    { 'norcalli/nvim-colorizer.lua', cmd="ColorizerToggle" },
    { 'lewis6991/gitsigns.nvim', config=true },
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
    { 'nvim-telescope/telescope.nvim', config=cfg_telescope, cmd="Telescope", dependencies={'fdschmidt93/telescope-egrepify.nvim'} },
    { 'nvim-treesitter/nvim-treesitter', config=cfg_treesitter, lazy=true },
    { 'nvim-neorg/neorg', ft="norg", opts=cfg_neorg, dependencies={"laher/neorg-exec"} },

    -->  GENERAL PURPOSE
    { 'danymat/neogen', opts={snippet_engine="luasnip"}, cmd="Neogen" },
    { 'notjedi/nvim-rooter.lua', config=true },
    { 'nvim-focus/focus.nvim', opts={ui = {cursorline=false, signcolumn=false}}, },
    { 'windwp/nvim-autopairs', config=true, event="InsertEnter" },
    { 'lukas-reineke/indent-blankline.nvim', opts={show_current_context=true, char='▏' } },
}

require("lazy").setup(pluhs, {
    ui = { pills=false, noautocmd=false },
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
local signs = { Error = "", Warn = "", Hint = "", Info = "", other = "﫠" }

for name, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. name
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

vim.lsp.handlers["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = Util.border})
vim.lsp.handlers["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = Util.border})

vim.diagnostic.config({
    virtual_text = false,
    underline = { Error=true },
    float = {
        border = Util.border, focusable = false, suffix = '',
        header = { "  Diagnostics", "String" },
        prefix = function(_, _, _) return "  " , "String" end, -- icons:        ﬌  
    }
})

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

local s = {
    pyright={}, tsserver={}, cssls={}, rust_analyzer={},
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
Util.splash_screen()
vim.cmd.colorscheme("retrobox")
vim.cmd [[
    hi link GitSignsAdd String
    hi link GitSignsChange Identifier
    hi link GitSignsDelete Keyword
    hi Function gui=italic
    hi link FloatBorder NormalFloat
    hi SignColumn guibg=none
]]

function UnusualFolds()
    local title = tostring(vim.fn.getline(vim.v.foldstart)):gsub([[%-%- %{%{%{ %-%- ]], "")
    local spaces = (" "):rep(math.floor(vim.o.columns - title:len()) / 2)

    return spaces .. title
end

vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "/home/taj/.config/nvim/init.lua",
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
vim.keymap.set('n', '"', ':', {})


vim.g.neovide_scale_factor = 1.0
vim.g.neovide_transparency = 0.7
vim.g.transparency = 0.7

vim.g.neovide_floating_blur_amount_x = 2.0
vim.g.neovide_floating_blur_amount_y = 2.0
vim.g.neovide_underline_automatic_scaling = true

vim.g.neovide_confirm_quit = true
vim.g.neovide_remember_window_size = true

vim.opt.cmdheight = 0
-- }}}
