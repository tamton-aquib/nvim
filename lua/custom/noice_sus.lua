M = {}

local function la_place(line)
	vim.fn.sign_define('sus', {text=' ඞ', texthl="Sus"})
	vim.fn.sign_place(line, '', 'sus', vim.fn.expand('%:p'),{lnum=line+1})
end

function M.sus()
	if vim.api.nvim_buf_line_count(0) > 100 then return end

	local lines = vim.api.nvim_buf_get_lines(0, 1, -1, false)
	vim.cmd [[ hi Sus guifg=#eb6c76 gui=bold ]] -- gui=underline

	for l, line in ipairs(lines) do
		if line:match("nice") or line:match("sus") or line:match("noice") then
			la_place(l)
		end
	end
end

function M.setup()
	vim.cmd [[au BufEnter,BufReadPost * lua require"custom.noice_sus".sus()]]
end

return M
