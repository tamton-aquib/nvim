local cmd = vim.api.nvim_command
local mapp = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local line = vim.fn.line

-------- twist ----------
function Swap_bool()
	local currentline = vim.api.nvim_get_current_line()
	if string.match(currentline, "true") then
		local subs = currentline:gsub("true", "false")
		vim.api.nvim_set_current_line(subs)
	elseif string.match(currentline, "false") then
		local subs = currentline:gsub("false", "true")
		vim.api.nvim_set_current_line(subs)
	end
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
	print(url)
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
	-- cmd [[PackerCompile]]
end

mapp('n', '<leader>u', ':lua Packer_do_everything()<CR>', opts)
---------------------

---------Comment----------
local comment_map = {
	javascript		= '%\\/%\\/',
	javascriptreact = '%\\/%\\/',
	c				= '%\\/%\\/',
	java			= '%\\/%\\/',
	rust			= '%\\/%\\/',
	python			= '#',
	sh				= '#',
	conf			= '#',
	yaml			= '#',
	lua				= '%-%-'
}

function Toggle_comment(status)
	local starting = vim.fn.getpos("'<")[2]
	local ending = vim.fn.getpos("'>")[2]

	local both = comment_map[vim.bo.ft]
	local backslash = both:gsub("%%", "")
	local percent = both:gsub([[\]], "")
    local current_line = vim.api.nvim_get_current_line()
    local cursor_position = vim.api.nvim_win_get_cursor(0)
    local noice = status and starting..','..ending or ""

	if string.find("^"..current_line, percent) ~= nil then
		cmd (noice..'norm ^'..('x'):rep(#backslash+1))
		vim.api.nvim_win_set_cursor(0, cursor_position)
	else
		cmd(noice..'norm I'..backslash..' ')
		vim.api.nvim_win_set_cursor(0, cursor_position)
	end
	if status then cmd [[norm gv]] end
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
