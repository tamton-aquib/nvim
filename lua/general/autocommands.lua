
--> NEW
vim.cmd [[au BufEnter * setlocal fo-=c fo-=r fo-=o]]
vim.cmd [[au BufEnter *.json set cole=0]]
vim.cmd [[au BufEnter *.md setlocal spell]]
vim.cmd [[au BufEnter packer.lua call matchadd("TSFuncBuiltin", ".*$")]]

--> LSP related
vim.cmd [[au BufWritePre *.js,*.jsx lua vim.lsp.buf.formatting_sync(nil, 200)]]
vim.cmd [[au BufWritePre *.rs,*.svelte lua vim.lsp.buf.formatting_sync(nil, 1000)]]
vim.cmd [[au CursorHold  * lua require("general.utils").show_diagnostics()]]
vim.cmd [[au CursorHoldI * lua if not require("cmp").visible() then vim.lsp.buf.signature_help({focusable=false}) end]]

--> OLD
vim.cmd [[au BufReadPost     *   lua require"essentials".last_place()]]
vim.cmd [[au FileType      help  nnoremap <buffer> <CR> <C-]>]]
vim.cmd [[au TextYankPost    *   silent! lua vim.highlight.on_yank{higroup="Folded", timeout=200} ]]
vim.cmd [[au BufEnter        *.toml   set ft=dosini]]
vim.cmd [[au TermOpen       term://*  setlocal nonu nornu | startinsert]]
vim.cmd [[au BufWritePost packer.lua  so % | PackerCompile<CR>]]
