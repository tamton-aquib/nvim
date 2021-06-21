vim.g.mapleader = ' '

local map = vim.api.nvim_set_keymap
local cmd = vim.api.nvim_command
local noice = {noremap=true, silent=true}

--> Custom
map('n', '<leader>f', [[:lua require('telescope.builtin').find_files(require'telescope.themes'.get_dropdown({previewer=false, width=0.5 }))<CR>]], noice)
map('i', 'jk', '<Esc>', noice)
map('n', '<leader>a','ggVG',noice)
map('n', '<leader>\'', 'ciw""<Esc>P', noice)
map('n', '<C-c>', ':w<CR>:silent !live_server<CR>', noice)
map('n', '<leader>n', ":lua require'lir.float'.toggle()<CR>", noice)
map('n', '<leader>h', ':Telescope help_tags<CR>', noice)
cmd('au Filetype lua nnoremap <silent> <leader>r :echo "Reloading..."<CR>:luafile %<CR>')

--> WINDOW Control
map('n', '<C-h>','<C-w>h', noice)
map('n', '<C-j>','<C-w>j', noice)
map('n', '<C-k>','<C-w>k', noice)
map('n', '<C-l>','<C-w>l', noice)
map('n', '<M-h>', ':vertical resize +2<CR>', noice)
map('n', '<M-j>', ':resize -2<CR>', noice)
map('n', '<M-k>', ':resize +2<CR>', noice)
map('n', '<M-l>', ':vertical resize -2<CR>', noice)

--> OLD
map('i', '<C-u>', '<Esc>viwUi', noice)
map('n', '<C-u>', 'viwU', noice)
map('n', '<TAB>', ':bnext<CR>', noice)
map('n', '<S-TAB>', ':bprevious<CR>', noice)
map('n', '<C-s>', ':w<CR>', noice)
map('n', '<C-q>', ':q<CR>', noice)
map('v', '<', '<gv', noice)
map('v', '>', '>gv', noice)
map('i', '<TAB>', 'pumvisible() ? "\\<C-n>" : "\\<TAB>"', {noremap=true, expr=true})

