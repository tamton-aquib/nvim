local Util = {}

Util.load_proj_config = function()
    -- TODO: add check for security?
    local file = vim.fn.getcwd() .. "/noice.json"
    -- local stuff = require("lspconfig").util.root_pattern('.git/')(vim.api.nvim_buf_get_name(0))
    -- print(vim.inspect(stuff))
    if vim.fn.filereadable(file) ~= 0 then
        local data = vim.json.decode(table.concat(vim.fn.readfile(file)))
        for key,map in pairs(data.keymaps or {}) do vim.keymap.set('n', key, '<cmd>silent w | '..map..'<CR>', {silent=true}) end
        for name,work in pairs(data.commands or {}) do vim.api.nvim_create_user_command(name, work, {}) end
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
Util.splash_screen = function()
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
            local keys = {K='kitty/kitty.conf', F='fish/config.fish', I='nvim/init.lua', A='alacritty/alacritty.yml', P='picom/picom.conf'}
            vim.api.nvim_win_set_buf(0, buf)
            vim.api.nvim_put(Util.center(header), "l", true, true)
            vim.cmd [[silent! setl nonu nornu acd ft=dashboard]]

            for k,f in pairs(keys) do vim.keymap.set('n', k,':e '..xdg..f..' | setl noacd<CR>', {buffer=0, silent=true}) end
            vim.keymap.set('n', 'P', '<cmd>Telescope oldfiles<CR>', {buffer=0})
            vim.keymap.set('n', 'q', '<cmd>q<CR>', {buffer=0})
        end)
    end
end

--> Closing Windows and buffers
Util.close_command = function()
    local buf_list = vim.api.nvim_list_bufs()
    for _, b in ipairs(buf_list) do if vim.bo[b].ft == "notify" then vim.notify.dismiss({}) return end end

    if vim.bo.modified then print("buf not saved!")  return end
    local total = #vim.tbl_filter(function(buf)
        return vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_name(buf) ~= ""
    end, buf_list)
    vim.cmd(total == 1 and ":q!" or ":bd!")
end

--> Different Kinds of Borders
local borders = {
    { "╒", "═", "╕", "│", "╛", "═", "╘", "│" },
    { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" }
}
Util.border = borders[2]

--> Custom telescope theme
Util.telescope_theme = {
    results_title = false,
    layout_strategy = "center",
    sorting_strategy = "ascending",
    previewer = false,
    prompt_prefix = "      ",
    winblend = 15,
    layout_config = { width = 0.6, height = 0.6 },
    borderchars = {
        preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        results = { "─", " ", " ", " ", "╰", "╯", " ", " " },
    },
}

--> Toggling quickfix window with a keybind
Util.toggle_quickfix = function()
    vim.cmd(not vim.g.quickfix_toggled and "cclose" or "copen")
    vim.g.quickfix_toggled = not vim.g.quickfix_toggled
end

return Util
