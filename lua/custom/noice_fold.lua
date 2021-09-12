M = {}

-- local function la_place(line)
	-- vim.fn.sign_define('fold', {text=' ', texthl="LspDiagnosticsSignError"})
	-- vim.fn.sign_place(line, 'foldgroup', 'fold', vim.fn.expand('%:p'),{lnum=line})
-- end

-- local function la_unplace()
	-- vim.fn.sign_unplace('foldgroup')
-- end

function M.fold_stuff()
	local fs = vim.v.foldstart
	local fe = vim.v.foldend

	local start_line = vim.fn.getline(fs)
	local end_line = vim.fn.getline(fe)
	local spaces = (" "):rep(vim.api.nvim_win_get_width(0) - 6 - start_line:len() - end_line:len())

	return start_line .. "  " .. end_line .. spaces
end

function M.setup()
	vim.cmd [[set foldtext=luaeval(\"require('custom.noice_fold').fold_stuff()\")]]
end

return M
