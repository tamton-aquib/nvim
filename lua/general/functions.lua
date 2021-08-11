local cmd = vim.api.nvim_command
local mapp = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local line = vim.fn.line

------ Timing scheme --------
function Timing_scheme()
    local hour = tonumber(os.date("%H"))
    local colo = ""
    if hour <= 15 then
	colo = "noice"
    elseif hour <= 20 then
	colo = "tokyonight"
    else
	colo = "sonokai"
    end
    require"themes.colorschemes"[colo](false)
end

-- cmd [[au BufEnter * lua Timing_scheme()]]
-----------------------------

-------- twist ----------
function Swap_bool()
	local c = vim.api.nvim_get_current_line()
	local subs = c:match("true") and c:gsub("true", "false") or c:gsub("false", "true")
	vim.api.nvim_set_current_line(subs)
end

mapp('n', '<leader>s', ':lua Swap_bool()<CR>', opts)
-------------------------

-----On BufEnter---------
function On_file_enter()
    if line([['"]]) > 1 and line([['"]]) <= line("$") then
	vim.cmd [[norm '"]]
    end
end

vim.cmd [[au BufEnter * lua On_file_enter()]]
-------------------------

-----Go To URL-------
function Go_To_URL()
    local url = vim.fn.expand('<cWORD>')
    require'notify'("Going to "..url, 'info', {title="Noice"})
    cmd(':silent !xdg-open '..url..' 1>/dev/null')
end
mapp('n', 'gx', ':lua Go_To_URL()<CR>', opts)
-- 'https://github.com'
---------------------

----Packer Reload----
function Packer_do_everything()
    cmd [[w]]
    cmd [[luafile ~/.config/nvim/lua/general/packer.lua]]
    cmd [[PackerSync]]
    require'notify'("Updating Plugins", 'info', {title="Packer"})
end

mapp('n', '<leader>u', ':lua Packer_do_everything()<CR>', opts)
---------------------

---------Comment----------
local comment_map = {
    javascript	= '//',
    typescript	= '//',
    javascriptreact = '//',
    c		= '//',
    java	= '//',
    rust	= '//',
    python	= '#',
    sh		= '#',
    conf	= '#',
    yaml	= '#',
    lua		= '--'
}

function Toggle_comment(visual)
    local starting, ending = vim.fn.getpos("'<")[2], vim.fn.getpos("'>")[2]

    local leader = comment_map[vim.bo.ft]
    local current_line = vim.api.nvim_get_current_line()
    local cursor_position = vim.api.nvim_win_get_cursor(0)
    local noice = visual and starting..','..ending or ""

    cmd(current_line:find("^%s?"..vim.pesc(leader))
	and noice..'norm ^'..('x'):rep(#leader+1)
	or noice..'norm I'..leader..' ')

    vim.api.nvim_win_set_cursor(0, cursor_position)
    -- if visual then cmd [[norm gv]] end
end

mapp('v', '<C-_>', ':lua Toggle_comment("nice")<CR>', opts)
mapp('n', '<C-_>', ':lua Toggle_comment()<CR>', opts)
---------------------------------------

--------Transparent Toggle-------------
local is_tranparent = 0
function Toggle_transparent()
    if (is_tranparent == 1) then
	cmd('hi Normal guibg=NONE ctermbg=NONE')
	is_tranparent = 0
    else
	vim.o.background = "dark"
	is_tranparent = 1
    end
end

mapp('n', '<C-t>', ':lua Toggle_transparent()<CR>', opts)
---------------------------------------
