vim.g.mapleader = ' '
local map = vim.api.nvim_set_keymap
local opts = {noremap=true, silent=true}

-- local function nnoremap(key)
	-- local arr = vim.split(key, ' ')
	-- local mode = table.remove(arr, 1)
	-- local map = table.remove(arr, 1)
-- 
	-- vim.api.nvim_set_keymap(mode, map, vim.fn.join(arr), opts)
-- end
-- 
-- nnoremap 'n <leader>s :lua require"general.functions".swap_bool()<CR>'

map('n', '<leader>s', ':lua require"general.functions".swap_bool()<CR>', opts)
map('n', 'gxx', ':lua require"general.functions".go_to_url()<CR>', opts)
map('n', 'gxm', ':lua require"general.functions".go_to_url("nice")<CR>', opts)
map('n', '<leader>u', ':lua require"general.functions".packer_do_everything()<CR>', {noremap=true})
map('n', '<C-t>', ':lua require"general.functions".toggle_transparent()<CR>', opts)
vim.cmd [[au BufEnter * lua require"general.functions".on_file_enter()]]

--> Custom
vim.cmd [[autocmd FileType help nnoremap <buffer> <CR> <C-]>]]
map('n', '<M-h>', ':lua vim.cmd(":vert :h "..vim.fn.expand("<cword>"))<CR>', opts)

--> WINDOW Control
map('n', '<C-h>','<C-w>h', opts)
map('n', '<C-j>','<C-w>j', opts)
map('n', '<C-k>','<C-w>k', opts)
map('n', '<C-l>','<C-w>l', opts)
map('n', '<M-Left>', ':vertical resize +2<CR>', opts)
map('n', '<M-Down>', ':resize -2<CR>', opts)
map('n', '<M-Up>', ':resize +2<CR>', opts)
map('n', '<M-Right>', ':vertical resize -2<CR>', opts)

-- Move selected line / block of text in visual mode
map("x", "<M-k>", ":move '<-2<CR>gv-gv", opts)
map("x", "<M-j>", ":move '>+1<CR>gv-gv", opts)
map('n', '<M-j>', ':m .+1<CR>==', opts)
map('n', '<M-k>', ':m .-2<CR>==', opts)

--> OLD
map('n', '<leader>a','ggVG',opts)
map('i', 'jk', '<Esc>', opts)
map('n', 'n', 'nzz', opts)
map('i', '<C-u>', '<Esc>viwUi', opts)
map('n', '<C-u>', 'viwU', opts)
map('n', '<TAB>', ':bnext<CR>', opts)
map('n', '<S-TAB>', ':bprevious<CR>', opts)
map('n', '<C-s>', ':w<CR>', opts)
map('n', '<C-q>', ':q<CR>', opts)
map('v', '<', '<gv', opts)
map('v', '>', '>gv', opts)

