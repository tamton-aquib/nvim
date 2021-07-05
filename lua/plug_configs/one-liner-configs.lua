
--> Markdown preview
vim.g.mkdp_refresh_slow = 1
vim.g.python_host_prog = '/usr/bin/python3'

--> TO-DO and lsp-icons
require'lspkind'.init({with_text=false})
-- require 'zen-mode'.setup{
-- 	window = {
-- 		backdrop = 0.5,
-- 		height = 0.8,
-- 		options = {
-- 			number = false,
-- 			relativenumber = false
-- 		}
-- 	}
-- }

--> Emmet configs
-- vim.g.user_emmet_leader_key=','
require'nvim-web-devicons'.setup({
	override = {
		lir_folder_icon = {
			icon = "",
			color = "#7ebae4",
			name = "LirFolderNode"
		},
	}
})

