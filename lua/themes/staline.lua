--> staline setup
-- #181a23    

require'stabline'.setup {
	style = 'bubble',
	fg = "#986fec",
	bg = "#181a23",
	stab_bg = "none"
}
--'right_sep', {'LspDiagnosticsSignError', '   '}, 'left_sep', 

require'staline'.setup{
	sections = {
		left = {
			' ', 'right_sep_double', '-mode', 'left_sep_double', ' ',
			'right_sep', '-filename', 'left_sep', ' ',
			'right_sep_double', '-branch', 'left_sep_double', ' ',},
		mid  = {'lsp'},
		right= {
			'right_sep', '-cool_symbol', 'left_sep', ' ',
			'right_sep',"- "..vim.bo.fileencoding:upper(), '- ', 'left_sep',
			'right_sep_double', '-line_column', 'left_sep_double', ' ',}
	},
	defaults={
		-- bg="#181a23",
		fg="#986fec",
		cool_symbol = "  ",
		left_separator = "",
		right_separator = "",
	},
-- 	mode_colors = {
-- 		n = "#986fec",
-- 		i = "#e86671",
-- 		ic= "#e86671",
-- 		c = "#e27d60"
-- 	}
	mode_colors = {
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

