local cmd = vim.api.nvim_command
local mapp = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-----Go To URL-------
function Go_To_URL()
	local url = vim.fn.expand('<cWORD>')
	cmd('!xdg-open '..url)
end
mapp('n', 'gx', ':lua Go_To_URL()<CR>', opts)
---------------------

----Packer Reload----
function Packer_do_everything()
	cmd [[w]]
	cmd [[luafile %]]
	cmd [[PackerSync]]
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

function Toggle_comment()
	local starting = vim.fn.getpos("'<")[2]
	local ending = vim.fn.getpos("'>")[2]

	local both = comment_map[vim.bo.ft]
	local backslash = both:gsub("%%", "")
	local percent = both:gsub([[\]], "")
	-- local neither = percent:gsub([[\]], "")

    local line = vim.api.nvim_get_current_line()

	if starting == ending then
		starting = "."
		ending = "."
	end

	if string.find("^"..line, percent) ~= nil then
		local comment = starting..','..ending..'s/^'..backslash..' //g'
		cmd(comment)
	else
		local uncommand = starting..','..ending..'s/^/'..backslash..' /g'
		cmd(uncommand)
	end
end

mapp('v', '<C-_>', ':lua Toggle_comment()<CR>', opts)
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

