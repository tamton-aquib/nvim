local M = {}
local opts = { noremap=true, silent=true }

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
    dosini	= '#',
    yaml	= '#',
    lua		= '--',
	svelte  = '//'
}

function M.toggle_comment(visual)
    local starting, ending = vim.fn.getpos("'<")[2], vim.fn.getpos("'>")[2]

    local leader = comment_map[vim.bo.ft]
    local current_line = vim.api.nvim_get_current_line()
    local cursor_position = vim.api.nvim_win_get_cursor(0)
    local noice = visual and starting..','..ending or ""

    vim.cmd(current_line:find("^%s*"..vim.pesc(leader))
	and noice..'norm ^'..('x'):rep(#leader+1)
	or noice..'norm I'..leader..' ')

    vim.api.nvim_win_set_cursor(0, cursor_position)
    -- if visual then vim.cmd [[norm gv]] end
end

function M.setup()
	vim.api.nvim_set_keymap('v', '<C-_>', ':lua require"custom.noice_comment".toggle_comment("nice")<CR>', opts)
	vim.api.nvim_set_keymap('n', '<C-_>', ':lua require"custom.noice_comment".toggle_comment()<CR>', opts)
end

return M
