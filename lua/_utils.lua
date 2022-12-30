local Util = {}

Util.mess = function()
    local contents = vim.api.nvim_exec("mess", true)
    if contents == "" then return end
    vim.cmd("vnew | setl bt=nofile bh=wipe nonu nornu")

    vim.api.nvim_put(vim.split(contents, '\n'), "", true, true)
end

--> Using `K` for docs related popups
Util.docs = function()
    if vim.api.nvim_buf_get_name(0):match("Cargo.toml$") then
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
            local map = function(lhs, rhs) vim.keymap.set('n', lhs, rhs, {silent=true, buffer=0}) end
            local keys = {K='kitty/kitty.conf', W='wezterm/wezterm.lua', I='nvim/init.lua', A='alacritty/alacritty.yml'}
            vim.api.nvim_win_set_buf(0, buf)
            vim.api.nvim_put(Util.center(header), "l", true, true)
            vim.cmd [[silent! setl nonu nornu acd ft=dashboard]]

            for k,f in pairs(keys) do map(k,'<cmd>e '..xdg..f..' | setl noacd<CR>') end
            map('P', '<cmd>Telescope oldfiles<CR>')
            map('q', '<cmd>q<CR>')
            map('o', '<cmd>e #<1<CR>')
        end)
    end
end

-- TODO: needs to be fixed.
--> Closing Windows and buffers
Util.close_command = function()
    for _, w in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_get_config(w)['relative'] ~= "" then
            vim.api.nvim_win_close(w, {force=true})
            return
        end
    end

    if vim.bo.modified then print("buf not saved!") return end
    local total = #vim.tbl_filter(function(buf)
        return vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_name(buf) ~= ""
    end, vim.api.nvim_list_bufs())

    -- TODO: buggy.
    local quit_cmd = #vim.api.nvim_list_wins() > 1 and 'Q' or 'q'
    vim.cmd(total == 1 and quit_cmd or 'bd')
end

--> Different Kinds of Borders
local borders = {
    { "╒", "═", "╕", "│", "╛", "═", "╘", "│" },
    { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" }
}
Util.border = borders[1]

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
    vim.cmd(
        #vim.tbl_filter(function(w)
            return vim.bo[vim.api.nvim_win_get_buf(w)].ft == "qf"
        end, vim.api.nvim_list_wins()) > 0
    and "cclose" or "copen")
end

return Util
