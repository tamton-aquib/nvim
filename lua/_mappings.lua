vim.g.mapleader = " "
local function map(mode, key, func) vim.keymap.set(mode, key, func, {silent=true}) end

--> stuff.nvim maps (https://github.com/tamton-aquib/stuff.nvim)
map('n', 'gC', function() require("calc").toggle() end)
-- map('n', 'gS', function() require("scratch").toggle() end)
map('n', 'gB', function() require("bt").toggle() end)
map('n', 'gO', function() require("tmpclone").clone() end)

--> TEMP and TEST maps
map('n', '<leader>l', function() require("essentials").toggle_term("lazygit", 't', true) end)
map('n', '<leader>t', function() require("essentials").toggle_term("fish", 'v', true) end)
map('n', '<leader>ps', '<cmd>w<CR>:so<CR>:PackerSync<CR>')
map('n', '<leader>pp', '<cmd>PackerProfile<CR>')
map('n', '<leader>ca', vim.lsp.buf.code_action)
map('n', 'K', function() require("_utils").docs() end)
map('n', 'ge', "<cmd>TroubleToggle<CR>")
map('t', '<C-n>', [[<C-\><C-n>]])
map('n', 'Q', '@q')

--> General Mappings
map('n', '<leader>dd'  , function() require("duck").hatch() end)
map('n', '<leader>dk'  , function() require("duck").cook() end)
map('n', '<leader>e'   , '<cmd>NvimTreeToggle<CR>')
map('n', '<leader>n'   , '<cmd>Neogen<CR>')
map('n', '<leader>q'   , require("_utils").toggle_quickfix)
map('n', '<leader>z'   , '<cmd>FocusMaximise<CR>')
map('n', '<leader>m'  , '<Plug>MarkdownPreviewToggle<CR>')
-- map('n', '<RightMouse>', '<RightMouse>:lua vim.lsp.buf.hover()<CR>')
-- map('n', '<LeftMouse>' , '<LeftMouse>:lua vim.lsp.buf.signature_help()<CR>')

--> Lsp mappings
map('n', 'gd',    vim.lsp.buf.definition)
map('n', 'gD',    vim.lsp.buf.declaration)
map('n', 'gr',    vim.lsp.buf.references)
map('n', 'gi',    vim.lsp.buf.implementation)
map('n', '<M-n>', vim.diagnostic.goto_next)
map('n', '<M-p>', vim.diagnostic.goto_prev)

--> essentials.nvim mappings ( https://github.com/tamton-aquib/essentials.nvim )
map('v', '<leader>/' , ':lua require("essentials").toggle_comment(true)<CR>')
map('n', '<leader>/' , ':lua require("essentials").toggle_comment()<CR>')
map('n', '<F2>'      , require("essentials").rename)
map('n', '<leader>r' , require("essentials").run_file)
map('n', '<leader>s' , require("essentials").swap_bool)
map('n', '<leader>w' , require("_utils").close_command)
map('n', 'gx'        , require("essentials").go_to_url)
map('n', '<leader>cs', require("essentials").cheat_sh)

--> Telescope mappings
map('n', '<leader>ff', function() require("telescope.builtin").find_files(require("_utils").telescope_theme) end)
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>')
map('n', '<leader>fp', '<cmd>Telescope projects<CR>')
map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>')
map('n', '<leader>fo', '<cmd>Telescope oldfiles<CR>')
map('n', '<leader>fc', '<cmd>Telescope commands theme=ivy<CR>')
-- map('n', '/', '<cmd>Telescope current_buffer_fuzzy_find previewer=false<CR>')

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
map("x", "<A-k>", ":move '<-2<CR>gv-gv")
map("x", "<A-j>", ":move '>+1<CR>gv-gv")
map("n", "<A-j>", ":move .+1<CR>==")
map("n", "<A-k>", ":move .-2<CR>==")

--> OLD
map('n', '<Space>'  , '<Nop>')
map('n', '<leader>a', 'ggVG')
map('i', 'jk'       , '<Esc>')
map('n', 'n'        , 'nzz')
map('n', '<TAB>'    , '<cmd>bnext<CR>')
map('n', '<S-TAB>'  , '<cmd>bprevious<CR>')
map('v', '<'        , '<gv')
map('v', '>'        , '>gv')
map('n', '>'        , '>>')
map('n', '<'        , '<<')
