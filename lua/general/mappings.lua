vim.g.mapleader = ' '
local opts = {noremap=true, silent=true}
local function map(mode, key, mapping) vim.api.nvim_set_keymap(mode, key, mapping, opts) end

--> Custom
map('n', '<leader>s', ':lua require"general.functions".swap_bool()<CR>')
map('n', 'gxx',       ':lua require"general.functions".go_to_url()<CR>')
map('n', 'gxm',       ':lua require"general.functions".go_to_url("github")<CR>')
map('n', '<leader>u', ':lua require"general.functions".packer_do_everything()<CR>')
map('n', '<C-t>',     ':lua require"general.functions".toggle_transparent()<CR>')
map('n', '<M-h>',     ':lua vim.cmd(":vert :h "..vim.fn.expand("<cword>"))<CR>')

vim.cmd [[au BufEnter * lua require"general.functions".on_file_enter()]]
vim.cmd [[autocmd FileType help nnoremap <buffer> <CR> <C-]>]]

--> WINDOW Control
map('n', '<C-h>',     '<C-w>h')
map('n', '<C-j>',     '<C-w>j')
map('n', '<C-k>',     '<C-w>k')
map('n', '<C-l>',     '<C-w>l')
map('n', '<M-Left>',  ':vertical resize +2<CR>')
map('n', '<M-Down>',  ':resize -2<CR>')
map('n', '<M-Up>',    ':resize +2<CR>')
map('n', '<M-Right>', ':vertical resize -2<CR>')

-- Move selected line / block of text in visual mode
map("x", "<M-k>", ":move '<-2<CR>gv-gv")
map("x", "<M-j>", ":move '>+1<CR>gv-gv")
map('n', '<M-j>', ':m .+1<CR>==')
map('n', '<M-k>', ':m .-2<CR>==')

--> OLD
map('n', '<leader>a','ggVG')
map('i', 'jk', '<Esc>')
map('n', 'n', 'nzz')
map('i', '<C-u>', '<Esc>viwUi')
map('n', '<C-u>', 'viwU')
map('n', '<TAB>', ':bnext<CR>')
map('n', '<S-TAB>', ':bprevious<CR>')
map('n', '<C-s>', ':w<CR>')
map('n', '<C-q>', ':q<CR>')
map('v', '<', '<gv')
map('v', '>', '>gv')

