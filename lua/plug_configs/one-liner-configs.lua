
--> Markdown preview
vim.g.mkdp_refresh_slow = 1
vim.g.python_host_prog = '/usr/bin/python3'

--> TO-DO and lsp-icons
require'todo-comments'.setup{}
require'lspkind'.init({with_text=false})

--> Nvim-Autopairs
require "pears".setup()

--> Emmet configs
vim.g.user_emmet_leader_key=','


--> Buferline
-- require("bufferline").setup{
-- 	diagnostics = "nvim_lsp",
-- 	separator_style = "thick"
-- }

