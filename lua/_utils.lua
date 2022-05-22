local Util = {}

-- TODO: later
Util.load_proj_config = function()
    -- TODO: add check for security?
    local file = vim.fn.getcwd() .. "/noice.json"
    if vim.fn.filereadable(file) ~= 0 then
        print("Loaded local config!")
        local data = vim.json.decode(table.concat(vim.fn.readfile(file)))
        for key,map in pairs(data.keymaps or {}) do vim.keymap.set('n', key, '<cmd>'..map..'<CR>', {silent=true}) end
        for name, work in pairs(data.commands or {}) do vim.api.nvim_create_user_command(name, work, {}) end
    end
end

--> Using `K` for docs related popups
Util.docs = function()
    if vim.tbl_contains({"lua", "help"}, vim.bo.ft) then
        vim.cmd(":h "..vim.fn.expand('<cword>'))
    elseif vim.api.nvim_buf_get_name(0):match("Cargo.toml$") then
        require("crates").show_popup()
    else
        vim.lsp.buf.hover()
    end
end

--> Centering an array of strings
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
Util.noice_board = function()
    local xdg = vim.fn.fnamemodify(vim.fn.stdpath("config"), ":h").."/"
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
    if vim.api.nvim_buf_get_name(0) == "" then
        vim.api.nvim_buf_set_option(0, 'bufhidden', 'wipe')

        vim.schedule(function()
            vim.fn.matchadd("Error", '[░▒]')
            vim.fn.matchadd("Function", '[▓█▄▀▐▌]')
            local buf = vim.api.nvim_create_buf(false, true)
            local keys = {
                K = xdg .. 'kitty/kitty.conf',
                F = xdg .. 'fish/config.fish',
                I = xdg .. 'nvim/init.lua',
                A = xdg .. 'alacritty/alacritty.yml',
                P = xdg .. 'picom/picom.conf'
            }
            vim.api.nvim_win_set_buf(0, buf)
            vim.api.nvim_put(Util.center(header), "l", true, true)
            vim.cmd [[silent! setlocal nonu nornu autochdir ft=dashboard]]

            for k,f in pairs(keys) do
                vim.keymap.set('n', k,':e '..f..' | setlocal noautochdir<CR>', {buffer=0, silent=true})
            end
            vim.keymap.set('n', 'P', '<cmd>Telescope oldfiles<CR>', {buffer=0})
            vim.keymap.set('n', 'q', '<cmd>q<CR>', {buffer=0})
        end)
    end
end

--> Closing Windows and buffers
Util.close_command = function(bt)
    if vim.bo.modified then print("buf not saved!")  return end
    local total = vim.api.nvim_list_bufs()
    total = #vim.tbl_filter(function(buf)
        -- if vim.bo.ft == bt then vim.api. end
        return vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_name(buf) ~= ""
    end, total)
    vim.cmd(total == 1 and ":q!" or ":bd!")
end


--> Different Kinds of Borders
local borders = {
    { "╒", "═", "╕", "│", "╛", "═", "╘", "│" },
    { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" },
    { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
}
Util.border = borders[1]

--> Custom telescope theme
Util.telescope_theme = {
    results_title = false,
    layout_strategy = "center",
    sorting_strategy = "ascending",
    previewer = false,
    prompt_prefix = "      ",
    winblend = 10,
    layout_config = { width = 0.6, height = 0.6 },
    borderchars = {
        preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        results = { "─", " ", " ", " ", "╰", "╯", " ", " " },
    },
}

--> Toggling quickfix window with a keybind
Util.toggle_quickfix = function()
    vim.cmd(not vim.g.quickfix_toggled and "copen" or "cclose")
    vim.g.quickfix_toggled = not vim.g.quickfix_toggled
end

return Util
