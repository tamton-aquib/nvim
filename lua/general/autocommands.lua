
--> NEW
vim.cmd [[au FileType lspinfo nnoremap q <cmd>q<CR>]]
vim.cmd [[au BufEnter *.toml set ft=dosini]]
vim.cmd [[au BufWritePost ~/.config/nvim/lua/general/packer.lua PackerCompile]]
vim.cmd [[au TermOpen term://* setlocal nonu nornu | startinsert]]

--> LSP related
vim.cmd [[au BufWritePre *.js,*.jsx,*.svelte lua vim.lsp.buf.formatting_sync(nil, 200)]]
vim.cmd [[au CursorHold  * lua vim.lsp.diagnostic.show_line_diagnostics({border = require"general.utils".border, focusable=false})]]
-- vim.cmd [[au CursorHoldI * lua vim.lsp.buf.signature_help({focusable=false})]]

--> OLD
vim.cmd [[au BufEnter        *    lua require"essentials".last_place()]]
vim.cmd [[au FileType       help  nnoremap <buffer> <CR> <C-]>]]
vim.cmd [[au TextYankPost    *    silent! lua vim.highlight.on_yank{higroup="Folded", timeout=200} ]]
