local map = vim.api.nvim_set_keymap
local opts = {noremap=true, silent=true}

map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)

map('n', '<C-n>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
map('n', '<C-p>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

vim.cmd [[au BufWritePre *.js,*.jsx lua vim.lsp.buf.formatting_sync(nil, 100)]]
-- vim.cmd [[au CursorHoldI * lua vim.lsp.buf.hover({focusable=false})]]
vim.cmd [[au CursorHoldI * lua vim.lsp.buf.hover()]]
vim.cmd [[au CursorHold  * lua vim.lsp.diagnostic.show_line_diagnostics({border = require"general.utils".border, focusable=false})]]
