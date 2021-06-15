local cmd = vim.api.nvim_command
local mapp = vim.api.nvim_set_keymap
local noice = {noremap=true, silent=true}

mapp('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', noice)
mapp('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', noice)
mapp('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', noice)
mapp('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', noice)
mapp('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', noice)
mapp('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', noice)
mapp('n', '<C-n>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', noice)
mapp('n', '<C-p>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', noice)

cmd('autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)')
cmd('autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)')
