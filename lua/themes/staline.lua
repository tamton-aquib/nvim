--> staline setup
-- local gruvbox = {
--     n = "#a89985",
--     i = "#84a598",
--     ic= "#84a598",
--     c = "#8fbf7f",
--     v = "#fc802d",    -- etc...
-- }

require'staline'.setup{
	sections = {
		left = {'mode', 'left_double_sep', 'branch', '  ', 'filename'},
		mid  = {'lsp'},
		right= { 'cool_symbol', '   ',vim.bo.fileencoding, 'right_double_sep', 'line_column'}
	},
	defaults = {
		cool_symbol = "  ",
		left_separator = "",
		right_separator = "",
		bg = "#303030",
		full_path = true
	},
	mode_colors = {
		n = "#986fec",
		i = "#e86671",
		ic= "#e86671",
		c = "#e27d60"
	}
	-- mode_colors = gruvbox
}

require'stabline'.setup {
	-- style = "slant",
	-- fg = "black",
	fg = "#986fec",
	-- fg = "#a89985"
	-- fg = "#000000"
-- 	stab_right = "",
-- 	stab_left = ""
	-- stab_right = "",
}

-- local leftSeparator = ""	-->      
-- local rightSeparator = ""	-->      

