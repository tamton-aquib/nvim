
--> NEW
vim.cmd [[au FileType lspinfo,help nnoremap q <cmd>q<CR>]]
vim.cmd [[au BufEnter *.toml set ft=dosini]]
vim.cmd [[au BufEnter *.json set cole=0]]
vim.cmd [[au BufWritePost packer.lua so % | PackerCompile<CR>]]
vim.cmd [[au TermOpen term://* setlocal nonu nornu | startinsert]]
vim.cmd [[au BufEnter github.com_*.txt set filetype=markdown]]

--> LSP related
vim.cmd [[au BufWritePre *.js,*.jsx,*.svelte lua vim.lsp.buf.formatting_sync(nil, 200)]]
vim.cmd [[au CursorHold  * lua vim.lsp.diagnostic.show_line_diagnostics({border = require"general.utils".border, focusable=false})]]
vim.cmd [[au CursorHoldI * lua vim.lsp.buf.signature_help({focusable=false})]]

--> OLD
vim.cmd [[au BufReadPost        *    lua require"essentials".last_place()]]
vim.cmd [[au FileType       help  nnoremap <buffer> <CR> <C-]>]]
vim.cmd [[au TextYankPost    *    silent! lua vim.highlight.on_yank{higroup="Folded", timeout=200} ]]
