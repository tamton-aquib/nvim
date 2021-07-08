--> staline setup

require'staline'.setup{
	defaults = {
		cool_symbol = "    ",
		left_separator = "",
		right_separator = "",
		fg = "#986fec",
		filename_section = "taj%#Noice#@%#NewSectionTwo#arch"
		-- filename_section = '%{luaeval("Get_lsp_stuff()")}'
	},
	mode_colors = {
		n = "none",
		i = "none",
		c = "none",
		v = "none",    -- etc...
	}
}

require'stabline'.setup{fg = "#986fec"}

-- vim.cmd[[hi NewSectionOne guifg=#986fec guibg=none]]
vim.cmd[[hi NewSectionTwo gui=bold guifg=none guibg=none]]

-- local leftSeparator = ""	-->      
-- local rightSeparator = ""	-->      

