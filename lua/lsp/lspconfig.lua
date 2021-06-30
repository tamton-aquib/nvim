local cmd = vim.api.nvim_command
local map = vim.api.nvim_set_keymap
local noice = {noremap=true, silent=true}
-- local c = vim.api.nvim_get_current_buf

map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', noice)
map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', noice)
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', noice)
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', noice)
map('n', 'K', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({border="single"})<CR>', noice)
-- map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', noice)
map('n', '<C-n>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', noice)
map('n', '<C-p>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', noice)

cmd('autocmd BufWritePre *.js,*.jsx lua vim.lsp.buf.formatting_sync(nil, 100)')

