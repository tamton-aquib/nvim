vim.g.mapleader = ' '
local opts = {noremap=true, silent=true}
local function map(mode, key, mapping) vim.api.nvim_set_keymap(mode, key, mapping, opts) end

--> TEMP and TEST maps
map('n', '<leader>w',  '<cmd>lua require("general.utils").close_command()<CR>')
map('n', '<leader>z',  ':FocusMaximise<CR>')
-- map('n', '<leader>z',  '<cmd>NeoZoomToggle<CR>')
map('n', '<leader>mp', '<cmd>MarkdownPreviewToggle<CR>')
map('n', "c", '"_c')
map('n', "C", '"_C')
map('n', '<leader>dd', '<cmd>lua require("duck").hatch()<CR>')
map('n', '<leader>dk', '<cmd>lua require("duck").cook()<CR>')
map('n', '<leader>n',  "<cmd>NvimTreeToggle<CR>")
map('n', '<M-h>',      '<cmd>lua vim.cmd(":h "..vim.fn.expand("<cword>").." | resize -6")<CR>')
map('n', '<RightMouse>', '<RightMouse>:lua vim.lsp.buf.hover({focusable=false})<CR>')
map('n', '<LeftMouse>' , '<LeftMouse>:lua vim.lsp.buf.signature_help({focusable=false})<CR>')
-- map('n', 'n', 'n:lua require("specs").show_specs()<CR>')
-- map('n', 'N', 'N:lua require("specs").show_specs()<CR>')

--> Packer commands
map('n', '<leader>ps', '<cmd>w<CR>:so %<CR>:PackerSync<CR>')
map('n', '<leader>pp', '<cmd>PackerProfile<CR>')
map('n', '<leader>pc', '<cmd>PackerCompile<CR>')

--> Goto-Preview maps
-- map('n', 'gd', '<cmd>lua require("goto-preview").goto_preview_definition()<CR>')
-- map('n', 'gi', '<cmd>lua require("goto-preview").goto_preview_implementation()<CR>')
-- map('n', 'gr', '<cmd>lua require("goto-preview").goto_preview_references()<CR>')

--> essentials.nvim mappings
map('n', '<F2>'     ,  '<cmd>lua require"essentials".rename()<CR>')
map('v', '<leader>/',  '<cmd>lua require"essentials".toggle_comment("nice")<CR>')
map('n', '<leader>/',  '<cmd>lua require"essentials".toggle_comment()<CR>')
map('n', '<leader>r',  '<cmd>w<CR>:lua require("essentials").run_file("horizontal")<CR>')
map('n', '<leader>s',  '<cmd>lua require"essentials".swap_bool()<CR>')
map('n', 'gx'       ,  '<cmd>lua require"essentials".go_to_url()<CR>')
map('v', 'gl'       ,  '<cmd>lua require"essentials".get_git_url()<CR>')
map('n', 'gl'       ,  '<cmd>lua require"essentials".get_git_url()<CR>')
map('n', '<leader>cs', '<cmd>lua require"essentials".cheat_sh()<CR>')

--> LSP mappings
map('n', 'gd',    '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', 'gD',    '<cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', 'gr',    '<cmd>lua vim.lsp.buf.references()<CR>')
-- map('n', 'gr',    ':NiceReference<CR>')
map('n', 'gi',    '<cmd>lua vim.lsp.buf.implementation()<CR>')
map('n', 'gh',    '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '<C-n>', '<cmd>lua vim.diagnostic.goto_next()<CR>')
map('n', '<C-p>', '<cmd>lua vim.diagnostic.goto_prev()<CR>')

--> Telescope mappings
map('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files(require("general.utils").telescope_theme)<CR>')
map('n', '<leader>fg', '<cmd>Telescope live_grep theme=cursor previewer=false<CR>')
map('n', '<leader>fa', '<cmd>Telescope lsp_code_actions theme=cursor<cr>')
map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>')
map('n', '<leader>fc', '<cmd>Telescope commands theme=ivy<CR>')

--> WINDOW Control
map('n', '<C-h>',     '<C-w>h')
map('n', '<C-j>',     '<C-w>j')
map('n', '<C-k>',     '<C-w>k')
map('n', '<C-l>',     '<C-w>l')
map('n', '<M-Left>',  '<cmd>vertical resize +2<CR>')
map('n', '<M-Down>',  '<cmd>resize -2<CR>')
map('n', '<M-Up>',    '<cmd>resize +2<CR>')
map('n', '<M-Right>', '<cmd>vertical resize -2<CR>')

--> Move selected line / block of text in visual mode
map("x", "<M-k>", "<cmd>move '<-2<CR>gv-gv")
map("x", "<M-j>", "<cmd>move '>+1<CR>gv-gv")
map("n", "<M-j>", "<cmd>m .+1<CR>==")
map("n", "<M-k>", "<cmd>m .-2<CR>==")

--> OLD
map('n', '<leader>a', 'ggVG')
map('i', 'jk'       , '<Esc>')
map('n', 'n'        , 'nzz')
map('n', '<TAB>'    , '<cmd>bnext<CR>')
map('n', '<S-TAB>'  , '<cmd>bprevious<CR>')
map('v', '<'        , '<gv')
map('v', '>'        , '>gv')
