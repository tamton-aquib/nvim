vim.g.mapleader = ' '
local opts = {noremap=true, silent=true}
local function map(mode, key, mapping) vim.api.nvim_set_keymap(mode, key, mapping, opts) end

--> NEW
map('n', '<leader>ps', ':w<CR>:so %<CR>:PackerSync<CR>')
map('n', '<leader>pp', ':PackerProfile<CR>')
map('n', '<M-h>',      ':lua vim.cmd(":h "..vim.fn.expand("<cword>"))<CR>')
map('n', '<leader>s',  ':lua require"general.functions".swap_bool()<CR>')
map('n', 'gx',         ':lua require"general.functions".go_to_url()<CR>')
map('n', '<C-t>',      ':lua require"general.functions".toggle_transparent()<CR>')

--> LSP mappings
map('n', 'gd',    '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', 'gD',    '<cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', 'gr',    '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', 'gi',    '<cmd>lua vim.lsp.buf.implementation()<CR>')
map('n', '<C-n>', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', '<C-p>', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')

--> Telescope mappings
map( 'n', '<leader>f', ':Telescope find_files theme=get_cursor previewer=false<CR>')
map( 'n', '<leader>g', ':Telescope live_grep theme=cursor previewer=false<CR>')
map( 'n', '<leader>h', ':Telescope help_tags<CR>')
map( 'n', '<leader>c', ':Telescope commands theme=ivy<CR>')

--> WINDOW Control
map('n', '<C-h>',     '<C-w>h')
map('n', '<C-j>',     '<C-w>j')
map('n', '<C-k>',     '<C-w>k')
map('n', '<C-l>',     '<C-w>l')
map('n', '<M-Left>',  ':vertical resize +2<CR>')
map('n', '<M-Down>',  ':resize -2<CR>')
map('n', '<M-Up>',    ':resize +2<CR>')
map('n', '<M-Right>', ':vertical resize -2<CR>')

--> Move selected line / block of text in visual mode
map("x", "<M-k>", ":move '<-2<CR>gv-gv")
map("x", "<M-j>", ":move '>+1<CR>gv-gv")
map("n", "<M-j>", ":m .+1<CR>==")
map("n", "<M-k>", ":m .-2<CR>==")

--> OLD
map('n', '<leader>a', 'ggVG')
map('i', 'jk'       , '<Esc>')
map('n', 'n'        , 'nzz')
map('n', '<TAB>'    , ':bnext<CR>')
map('n', '<S-TAB>'  , ':bprevious<CR>')
map('n', '<C-s>'    , ':w<CR>')
map('n', '<C-q>'    , ':q<CR>')
map('v', '<'        , '<gv')
map('v', '>'        , '>gv')
-- map('i', '<C-u>', '<Esc>viwUi')
-- map('n', '<C-u>', 'viwU')
