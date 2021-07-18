M = {}

function M.post()
	local new = vim.api.nvim_get_current_line()
	vim.api.nvim_buf_delete(M.noice_buf, {force=true})
	vim.lsp.buf.rename(vim.trim(new))
	print(M.rename_old..' -> '..new)
	vim.cmd [[stopinsert!]]
end

function M.pre()
	M.rename_old = vim.fn.expand('<cword>')
	M.noice_buf = vim.api.nvim_create_buf(false, false)
	vim.api.nvim_open_win(M.noice_buf, true, {relative='cursor', row=1, col=1,  width=10, height=1, style='minimal'})
	vim.cmd [[startinsert]]
	vim.api.nvim_buf_set_keymap(M.noice_buf, 'i', '<CR>', '<cmd>lua require"custom.noice_rename".post()<CR>', {noremap=true, silent=true})
end

function M.setup()
	vim.api.nvim_set_keymap('n', '<F2>', ':lua require"custom.noice_rename".pre()<CR>', {noremap=true, silent=true})
end

return M
