
--> Markdown preview
vim.g.mkdp_refresh_slow = 1
vim.g.python_host_prog = '/usr/bin/python3'

--> TO-DO and lsp-icons
require'todo-comments'.setup{}
require'lspkind'.init({with_text=false})
require 'zen-mode'.setup{
	window = {
		backdrop = 0.5,
		height = 0.8,
		options = {
			number = false,
			relativenumber = false
		}
	}
}

--> Nvim-Autopairs
require "pears".setup()

--> Emmet configs
-- vim.g.user_emmet_leader_key=','

