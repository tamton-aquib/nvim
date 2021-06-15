local cmd = vim.api.nvim_command
local map = vim.api.nvim_set_keymap
local noice = {noremap=true, silent=true}

map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', noice)
map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', noice)
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', noice)
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', noice)
map('n', 'K', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics({border="shadow"})<CR>', noice)
map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', noice)
map('n', '<C-n>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', noice)
map('n', '<C-p>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', noice)
-- map('n', '<leader>k', '<cmd>lua vim.lsp.buf.hover({border="double"})<CR>', noice)

cmd('autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)')
cmd('autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)')

cmd('sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsSignError')
cmd('sign define LspDiagnosticsSignWarning text=  texthl=LspDiagnosticsSignWarning')
cmd('sign define LspDiagnosticsSignHint text= texthl=LspDiagnosticsSignHint')
cmd('sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsSignInformation')

cmd('hi LspDiagnosticsUnderlineError gui=undercurl')

