vim.g.mapleader = " "
local function map(mode, key, func) vim.keymap.set(mode, key, func, {silent=true}) end

--> TEMP and TEST maps
map('n', '<leader>l', function() require("essentials").open_term("lazygit", 't', true) end)
map('n', '<leader>t', function() require("essentials").open_term("fish", 'h', true) end)

--> General Mappings
map('n', '<M-h>'       , ':exe ":h ".expand("<cword>")<CR>')
map('n', '<leader>dd'  , require("duck").hatch)
map('n', '<leader>dk'  , require("duck").cook)
map('n', '<leader>n'   , '<cmd>NvimTreeToggle<CR>')
map('n', '<leader>q'   , require("general.utils").toggle_quickfix)
map('n', '<leader>z'   , '<cmd>FocusMaximise<CR>')
map('n', '<leader>mp'  , '<Plug>MarkdownPreviewToggle<CR>')
map('n', '<RightMouse>', '<RightMouse>:lua vim.lsp.buf.hover()<CR>')
map('n', '<LeftMouse>' , '<LeftMouse>:lua vim.lsp.buf.signature_help()<CR>')

--> Packer commands
map('n', '<leader>ps', '<cmd>w<CR>:so %<CR>:PackerSync<CR>')
map('n', '<leader>pp', '<cmd>PackerProfile<CR>')
map('n', '<leader>pc', '<cmd>PackerCompile<CR>')

--> essentials.nvim mappings ( https://github.com/tamton-aquib/essentials.nvim )
map('v', '<leader>/' , ':lua require("essentials").toggle_comment(true)<CR>')
map('n', '<leader>/' , ':lua require("essentials").toggle_comment()<CR>')
map('n', '<F2>'      , require("essentials").rename)
map('n', '<leader>r' , require("essentials").run_file)
map('n', '<leader>s' , require("essentials").swap_bool)
map('n', '<leader>w' , require("general.utils").close_command)
map('n', 'gx'        , require("essentials").go_to_url)
map('n', '<leader>cs', require("essentials").cheat_sh)
-- map('v', 'gl', require("essentials").get_git_url)

--> Telescope mappings
map('n', '<leader>ff', function() require("telescope.builtin").find_files(require("general.utils").telescope_theme) end)
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>')
map('n', '<leader>fa', '<cmd>Telescope lsp_code_actions theme=cursor<cr>')
map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>')
map('n', '<leader>fc', '<cmd>Telescope commands theme=ivy<CR>')

--> WINDOW Control
map('n', '<C-h>'    , '<C-w>h')
map('n', '<C-j>'    , '<C-w>j')
map('n', '<C-k>'    , '<C-w>k')
map('n', '<C-l>'    , '<C-w>l')
map('n', '<M-Left>' , '<cmd>vertical resize +2<CR>')
map('n', '<M-Down>' , '<cmd>resize -2<CR>')
map('n', '<M-Up>'   , '<cmd>resize +2<CR>')
map('n', '<M-Right>', '<cmd>vertical resize -2<CR>')

--> Move selected line / block of text in visual mode
map("x", "<M-k>", "<cmd>move '<-2<CR>gv-gv")
map("x", "<M-j>", "<cmd>move '>+1<CR>gv-gv")
map("n", "<M-j>", "<cmd>m .+1<CR>==")
map("n", "<M-k>", "<cmd>m .-2<CR>==")

--> OLD
map('n', '<Space>'  , '<Nop>')
map('n', '<leader>a', 'ggVG')
map('i', 'jk'       , '<Esc>')
map('n', 'n'        , 'nzz')
map('n', '<TAB>'    , '<cmd>bnext<CR>')
map('n', '<S-TAB>'  , '<cmd>bprevious<CR>')
map('v', '<'        , '<gv')
map('v', '>'        , '>gv')
