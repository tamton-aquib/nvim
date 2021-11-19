
--> NEW
vim.cmd [[au BufEnter,FileType * setlocal fo-=c fo-=r fo-=o]]
vim.cmd [[au BufEnter *.json set cole=0]]
vim.cmd [[au BufEnter,FileType startup nnoremap <silent> I :e ~/.config/nice/init.lua<CR>]]
vim.cmd [[au InsertLeave,BufEnter *.rs :w]]
vim.cmd [[au BufEnter *.md set spell]]

--> LSP related
vim.cmd [[au BufWritePre *.js,*.jsx,*.svelte lua vim.lsp.buf.formatting_sync(nil, 200)]]
vim.cmd [[au CursorHold  * lua vim.lsp.diagnostic.show_line_diagnostics({border = require"general.utils".border, focusable=false})]]
vim.cmd [[au CursorHoldI * lua if not require("cmp").visible() then vim.lsp.buf.signature_help({focusable=false}) end]]

--> OLD
vim.cmd [[au BufReadPost     *    lua require"essentials".last_place()]]
vim.cmd [[au FileType      help  nnoremap <buffer> <CR> <C-]>]]
vim.cmd [[au TextYankPost    *    silent! lua vim.highlight.on_yank{higroup="Folded", timeout=200} ]]
-- vim.cmd [[au FileType     lspinfo,help nnoremap q <cmd>q<CR>]]
vim.cmd [[au BufEnter     *.toml set ft=dosini]]
vim.cmd [[au TermOpen     term://* setlocal nonu nornu | startinsert]]
vim.cmd [[au BufWritePost packer.lua so % | PackerCompile<CR>]]
