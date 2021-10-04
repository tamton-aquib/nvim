
--> NEW
vim.cmd [[au FileType lspinfo nnoremap q <cmd>q<CR>]]
vim.cmd [[au BufEnter *.toml set ft=dosini]]
vim.cmd [[au BufWritePost ~/.config/nvim/lua/general/packer.lua PackerCompile]]
-- vim.cmd [[au BufWritePost ~/.config/nvim/lua/custom/noice_dark.lua colo noice]]
vim.cmd [[au TermOpen term://* lua require"general.functions".term_opts()]]

--> LSP related
vim.cmd [[au BufWritePre *.js,*.jsx,*.svelte lua vim.lsp.buf.formatting_sync(nil, 200)]]
vim.cmd [[au CursorHold  * lua vim.lsp.diagnostic.show_line_diagnostics({border = require"general.utils".border, focusable=false})]]
-- vim.cmd [[au CursorHoldI * lua vim.lsp.buf.signature_help({focusable=false})]]

--> OLD
vim.cmd [[au BufEnter        *    lua require"general.functions".on_file_enter()]]
vim.cmd [[au FileType       help  nnoremap <buffer> <CR> <C-]>]]
vim.cmd [[au TextYankPost    *    silent! lua vim.highlight.on_yank{higroup="Folded", timeout=200} ]]
