vim.g.mapleader = " "
local gline, buf
local plugin_list = {}
local curl = require("plenary.curl")
local path = vim.fn.stdpath("config") .. "/plugins.json"

local install_selected_plugin = function()
    local result = vim.trim(vim.api.nvim_get_current_line())
    local selected = plugin_list[result].full_name

    local f = io.open(path, "r")
    local obj
    if f ~= nil then
        local contents = f:read("*a")
        obj = vim.json.decode(contents)
        table.insert(obj, {url=[[https://github.com/]]..selected, config=true})
        f:close()
    else
        vim.notify("Error reading the file!")
        return
    end

    f = io.open(path, "w")
    if f ~= nil then
        local new_content = vim.fn.json_encode(obj)
        f:write(new_content)
        vim.notify("Wrote the new plugin to plugins.json!")
        f:close()
    end
end

local refresh = function()
    vim.schedule(function()
        vim.api.nvim_buf_set_lines(buf, 1, -1, false, {})
        local t = vim.tbl_keys(plugin_list)
        vim.api.nvim_buf_set_lines(buf, 1, 2, false, t)
    end)
end

local update_lines = function(d)
    plugin_list = vim.json.decode(d)
    refresh()
end

local update_list = function()
    local line = vim.api.nvim_buf_get_lines(buf, 0, 1, true)[1]

    if vim.bo.ft ~= "lazy_search" or line:len() < 3 or line == gline then
        return
    end

    curl.get("https://api.nvimplugnplay.repl.co/search?max_count=10&query="..line, {
        callback=function(d) update_lines(d.body) end
    })

    gline = line
end

local pick = function()
    buf = vim.api.nvim_create_buf(false, true)
    vim.cmd [[leftabove vsplit | vert resize 30]]
    vim.api.nvim_set_current_buf(buf)
    vim.cmd [[set nonu nornu]]
    require("essentials.utils").set_quit_maps()
    vim.bo[buf].ft = "lazy_search"

    vim.keymap.set({"i", "n"}, "<CR>", install_selected_plugin, { buffer=buf })
    vim.api.nvim_create_autocmd('CursorHoldI', { callback=update_list })
end

vim.keymap.set('n', '<leader>k', pick, {})
