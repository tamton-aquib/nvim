M = {}

local function la_place(line)
	vim.fn.sign_define('sus', {text=' ඞ', texthl="Sus"})
	vim.fn.sign_place(line, '', 'sus', vim.fn.expand('%:t'),{lnum=line+1})
end

function M.setup()
	if vim.api.nvim_buf_line_count(0) > 100 then return end

	vim.schedule(function()
		local lines = vim.api.nvim_buf_get_lines(0, 1, -1, false)
		vim.cmd [[ hi Sus guifg=#f7768e gui=underline ]]
		-- nice
		for l, line in ipairs(lines) do
			if line:match("nice") then
				la_place(l)
			end
		end
	end)
end

return M
