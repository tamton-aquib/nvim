
--> NEW
vim.cmd [[au BufEnter * set fo-=cro]]
vim.cmd [[au BufEnter *.json set cole=0]]
vim.cmd [[au BufEnter *.md setlocal spell]]
vim.cmd [[au BufEnter packer.lua,init.lua call matchadd("Keyword", ".*$")]]

--> LSP related
vim.cmd [[au BufWritePre *.js,*.jsx lua vim.lsp.buf.formatting_sync(nil, 200)]]
vim.cmd [[au BufWritePre *.rs,*.svelte lua vim.lsp.buf.formatting_sync(nil, 1000)]]
vim.cmd [[au CursorHoldI * lua if not require("cmp").visible() then vim.lsp.buf.signature_help({focusable=false}) end]]
vim.cmd [[au CursorHold  * lua vim.diagnostic.open_float()]]

--> OLD
vim.cmd [[au BufReadPost     *   lua require"essentials".last_place()]]
vim.cmd [[au FileType      help  nnoremap <buffer> <CR> <C-]>]]
vim.cmd [[au TextYankPost    *   silent! lua vim.highlight.on_yank{higroup="Folded", timeout=200} ]]
vim.cmd [[au BufEnter        *.toml   set ft=dosini]]
vim.cmd [[au TermOpen       term://*  setlocal nonu nornu | startinsert]]
vim.cmd [[au BufWritePost packer.lua  so % | PackerCompile<CR>]]

--> Commands
vim.cmd [[command X :!xset r rate 170 69]]
