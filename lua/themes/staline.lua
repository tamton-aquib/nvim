--> staline setup
-- #181a23    

require'stabline'.setup {
	style = 'bubble',
	fg = "#986fec",
	bg = "#181a23"
}

require'staline'.setup{
	sections = {
		left = {
			' ', 'right_sep_double','-mode', 'left_sep_double', ' ',
			'right_sep', '-filename', 'left_sep', ' ',
			'right_sep', '-branch', 'left_sep', ' ',},
		mid  = {'lsp'},
		right= {
			'right_sep', '-cool_symbol', 'left_sep', ' ',
			'right_sep',"- "..vim.bo.fileencoding, '- ', 'left_sep',
			'right_sep_double', '-line_column', 'left_sep_double', ' ',}
	},
	defaults={
		-- bg="#181a23",
		fg="#986fec",
		cool_symbol = "  ",
		left_separator = "",
		right_separator = "",
	},
	mode_colors = {
		-- #181a23
		n = "#181a23",
		i = "#181a23",
		ic= "#181a23",
		c = "#181a23"
	}
}

-- local gruvbox = {
--     n = "#a89985",
--     i = "#84a598",
--     ic= "#84a598",
--     c = "#8fbf7f",
--     v = "#fc802d",    -- etc...
-- }


-- local leftSeparator = ""	-->      
-- local rightSeparator = ""	-->      

