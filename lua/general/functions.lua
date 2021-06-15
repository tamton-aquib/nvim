local cmd = vim.api.nvim_command
local mapp = vim.api.nvim_set_keymap

local comment_map = { 
		c			= '%\\/%\\/',
		java		= '//',
		javascript	= '%\\/%\\/',
		python		= '#',
		sh			= '#',
		vim			= '"',
		rust		= '%\\/%\\/',
		lua			= '%-%-',
		conf		= '#'
}

function toggle_comment()
	local extension = vim.bo.ft
	local comment_match = comment_map[extension]
	local comment_leader = comment_match:gsub("%%", "")
    local _, starting, _, _ = unpack(vim.fn.getpos("'<"))
    local _, ending, _, _	= unpack(vim.fn.getpos("'>"))

    local line = vim.api.nvim_get_current_line()

	if starting == 0 and ending == 0 then
		starting = "."
		ending = "."
	end

	if line:match("^"..comment_match) then
		local uncomment = starting..','..ending..'s/^'..comment_leader..' //g'
		cmd(uncomment)
	else
		local comment = starting..','..ending..'s/^/'..comment_leader..' /g'
		cmd(comment)
	end
end

mapp('v', '<C-_>', ':lua toggle_comment()<CR>', {noremap=true, silent=true})
mapp('n', '<C-_>', ':lua toggle_comment()<CR>', {noremap=true})

local is_tranparent = 1
function toggle_transparent()
	if (is_tranparent == 0)
		then
        cmd('hi Normal guibg=NONE ctermbg=NONE')
		is_tranparent = 1
	else
        vim.o.background = "dark"
		is_tranparent = 0
	end
end

mapp('n', '<C-t>', ':lua toggle_transparent()<CR>', {noremap=true})

