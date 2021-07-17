--> staline setup
-- function Get_lsp_stuff()
-- 	return vim.lsp.diagnostic.get_count(0, 'Error')
-- end

require'staline'.setup{
	defaults = {
		cool_symbol = " ",
		left_separator = "",
		right_separator = "",
		-- fg = "#986fec",
		-- filename_section = "taj%#Noice#@%#NewSectionTwo#arch"
		-- filename_section = "%{luaeval('Get_lsp_stuff()')}"
	},
-- 	mode_colors = {
-- 		n = "#986fec",
-- 		i = "#",
	mode_colors = {
		n = "#986fec",
		i = "#e86671",
		ic= "#e86671",
		c = "#e27d60"
	}
-- 		ic= "none",
-- 		c = "none",
-- 		v = "none",
-- 		V = "none",
-- 		t = "none",
}

require'stabline'.setup{
	fg = "#986fec",
	-- fg = "#000000"
-- 	stab_right = "",
-- 	stab_left = ""
}

-- vim.cmd[[hi NewSectionOne guifg=#986fec guibg=none]]
-- vim.cmd[[hi NewSectionTwo gui=bold guifg=none guibg=none]]

-- local leftSeparator = ""	-->      
-- local rightSeparator = ""	-->      

