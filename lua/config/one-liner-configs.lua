
--> Markdown preview
vim.g.mkdp_refresh_slow = 1
vim.g.python_host_prog = '/usr/bin/python3'

--> TO-DO and lsp-icons
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

require'nvim-web-devicons'.setup({
	override = {
		lir_folder_icon = {
			icon = "",
			color = "#7ebae4",
			name = "LirFolderNode"
		},
	}
})

