vim.g.mapleader = ' '
local map = vim.api.nvim_set_keymap
local noice = {noremap=true, silent=true}

--> Custom
map('n', '<CR>', ':PackerProfile<CR>', noice)
-- map('n', '<leader>\'', 'ciw""<Esc>P', noice)
vim.cmd [[autocmd FileType help nnoremap <buffer> <CR> <C-]>]]
map('n', '<C-h>', ':lua vim.cmd(":vert :h "..vim.fn.expand("<cword>"))<CR>', noice)
-- cmd('au BufWritePost Filetype *.lua luafile %')

--> WINDOW Control
-- map('n', '<C-h>','<C-w>h', noice)
-- map('n', '<C-j>','<C-w>j', noice)
-- map('n', '<C-k>','<C-w>k', noice)
-- map('n', '<C-l>','<C-w>l', noice)
map('n', '<M-h>', ':vertical resize +2<CR>', noice)
map('n', '<M-j>', ':resize -2<CR>', noice)
map('n', '<M-k>', ':resize +2<CR>', noice)
map('n', '<M-l>', ':vertical resize -2<CR>', noice)

-- Move selected line / block of text in visual mode
map("x", "K", ":move '<-2<CR>gv-gv", noice)
map("x", "J", ":move '>+1<CR>gv-gv", noice)
map('n', '<C-j>', ':m .+1<CR>==', noice)
map('n', '<C-k>', ':m .-2<CR>==', noice)

--> OLD
map('n', '<leader>a','ggVG',noice)
map('i', 'jk', '<Esc>', noice)
map('n', 'n', 'nzz', noice)
map('i', '<C-u>', '<Esc>viwUi', noice)
map('n', '<C-u>', 'viwU', noice)
map('n', '<TAB>', ':bnext<CR>', noice)
map('n', '<S-TAB>', ':bprevious<CR>', noice)
map('n', '<C-s>', ':w<CR>', noice)
map('n', '<C-q>', ':q<CR>', noice)
map('v', '<', '<gv', noice)
map('v', '>', '>gv', noice)

