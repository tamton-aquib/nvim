
--> Markdown preview
vim.g.mkdp_refresh_slow = 1
vim.g.python_host_prog = '/usr/bin/python3'

--> TO-DO and lsp-icons
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

require'gitsigns'.setup {
	signs = {
		 delete = {hl = 'GitSignsDelete', text = '│', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
	}
}

require "pears".setup(function(conf)
	conf.on_enter(function(pears_handle)
		if vim.fn.pumvisible() == 1 and vim.fn.complete_info().selected ~= -1 then
			return vim.fn["compe#confirm"]("<CR>")
		else
			pears_handle()
		end
	end)
end)

require'nvim-web-devicons'.setup({
	override = {
		lir_folder_icon = {
			icon = "",
			color = "#7ebae4",
			name = "LirFolderNode"
		},
	}
})

