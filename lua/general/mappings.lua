vim.g.mapleader = " "
local function mep(mode, key, func) vim.keymap.set(mode, key, func, {silent=true}) end

--> TEMP and TEST maps
mep('n', '<leader>l', function() require("general.utils").open_term("lazygit", 't', true) end)
mep('n', '<leader>t', function() require("general.utils").open_term("fish", 'h', true) end)
-- mep('n', "c", '"_c')
-- mep('n', "C", '"_C')

--> General Mappings
mep('n', '<M-h>'       , ':exe ":h ".expand("<cword>")<CR>')
mep('n', '<leader>dd'  , require("duck").hatch)
mep('n', '<leader>dk'  , require("duck").cook)
mep('n', '<leader>n'   , '<cmd>NvimTreeToggle<CR>')
mep('n', '<leader>q'   , require("general.utils").toggle_quickfix)
mep('n', '<leader>z'   , '<cmd>FocusMaximise<CR>')
mep('n', '<leader>mp'  , '<cmd>MarkdownPreviewToggle<CR>')
mep('n', '<RightMouse>', '<RightMouse>:lua vim.lsp.buf.hover()<CR>')
mep('n', '<LeftMouse>' , '<LeftMouse>:lua vim.lsp.buf.signature_help()<CR>')

--> Packer commands
mep('n', '<leader>ps', '<cmd>w<CR>:so %<CR>:PackerSync<CR>')
mep('n', '<leader>pp', '<cmd>PackerProfile<CR>')
mep('n', '<leader>pc', '<cmd>PackerCompile<CR>')

--> essentials.nvim mappings ( https://github.com/tamton-aquib/essentials.nvim )
mep('v', '<leader>/' , ':lua require("essentials").toggle_comment(true)<CR>')
mep('n', '<leader>/' , ':lua require("essentials").toggle_comment()<CR>')
mep('n', '<F2>'      , require("essentials").rename)
mep('n', '<leader>r' , require("essentials").run_file)
mep('n', '<leader>s' , require("essentials").swap_bool)
mep('n', '<leader>w' , require("general.utils").close_command)
mep('n', 'gx'        , require("essentials").go_to_url)
mep('n', '<leader>cs', require("essentials").cheat_sh)
mep('v', 'gl'        , require("essentials").get_git_url)

--> LSP mappings
mep('n', 'gd',    vim.lsp.buf.definition)
mep('n', 'gD',    vim.lsp.buf.declaration)
mep('n', 'gr',    vim.lsp.buf.references)
mep('n', 'gi',    vim.lsp.buf.implementation)
mep('n', 'gh',    vim.lsp.buf.hover)
mep('n', '<C-n>', vim.diagnostic.goto_next)
mep('n', '<C-p>', vim.diagnostic.goto_prev)

--> Telescope mappings
mep('n', '<leader>ff', function() require("telescope.builtin").find_files(require("general.utils").telescope_theme) end)
mep('n', '<leader>fg', '<cmd>Telescope live_grep<CR>')
mep('n', '<leader>fa', '<cmd>Telescope lsp_code_actions theme=cursor<cr>')
mep('n', '<leader>fh', '<cmd>Telescope help_tags<CR>')
mep('n', '<leader>fc', '<cmd>Telescope commands theme=ivy<CR>')

--> WINDOW Control
mep('n', '<C-h>'    , '<C-w>h')
mep('n', '<C-j>'    , '<C-w>j')
mep('n', '<C-k>'    , '<C-w>k')
mep('n', '<C-l>'    , '<C-w>l')
mep('n', '<M-Left>' , '<cmd>vertical resize +2<CR>')
mep('n', '<M-Down>' , '<cmd>resize -2<CR>')
mep('n', '<M-Up>'   , '<cmd>resize +2<CR>')
mep('n', '<M-Right>', '<cmd>vertical resize -2<CR>')

--> Move selected line / block of text in visual mode
mep("x", "<M-k>", "<cmd>move '<-2<CR>gv-gv")
mep("x", "<M-j>", "<cmd>move '>+1<CR>gv-gv")
mep("n", "<M-j>", "<cmd>m .+1<CR>==")
mep("n", "<M-k>", "<cmd>m .-2<CR>==")

--> OLD
mep('n', '<Space>'  , '<Nop>')
mep('n', '<leader>a', 'ggVG')
mep('i', 'jk'       , '<Esc>')
mep('n', 'n'        , 'nzz')
mep('n', '<TAB>'    , '<cmd>bnext<CR>')
mep('n', '<S-TAB>'  , '<cmd>bprevious<CR>')
mep('v', '<'        , '<gv')
mep('v', '>'        , '>gv')
