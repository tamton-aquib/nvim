--> staline setup
-- #181a23    

require'stabline'.setup {
	style = 'bar',
	font_active = "bold,italic",
	font_inactive = "italic",
	fg = "#986fec",
	-- bg = "#181a23",
	-- stab_bg = "none"
}
--'right_sep', {'LspDiagnosti csSignError', '   '}, 'left_sep',

require 'staline'.setup {
	sections = {
		left = {' ', '', '-   ', {'FileNameHighlight', 'filename'}, {'FileNameRightSepHighlight',''}, 'branch' },
		mid = {'lsp'},
		right = {'', '-mode', {'FileNameHighlight', ' [%c]'}, {'FileNameRightSepHighlight',''}, '  ' },
	},
	defaults = {
		font_active = "bold,italic",
	},
	mode_icons = {
		n = "NORMAL"
	},
	mode_colors = {
		-- n = "#e95678",
		n = "#986fec",
		i = "#9ece6a",
		ic= "#9ece6a"
	}
}

vim.cmd [[hi FileNameHighlight guifg=white guibg=#393b4d]]
vim.cmd [[hi FileNameRightSepHighlight guifg=#393b4d]]
vim.cmd [[hi BranchGreen guibg=#a3be8c guifg=black]]
-- ;#a3be8c

-- require'staline'.setup{
-- 	sections = {
-- 		left = {
-- 			' ', 'right_sep_double', '-mode', 'left_sep_double', ' ',
-- 			'right_sep', '-filename', 'left_sep', ' ',
-- 			'right_sep_double', '-branch', 'left_sep_double', ' ',},
-- 		mid  = {'lsp', 'client_name'},
-- 		right= {
-- 			'right_sep', '-cool_symbol', 'left_sep', ' ',
-- 			'right_sep',"- "..vim.bo.fileencoding:upper(), '- ', 'left_sep',
-- 			'right_sep_double', '-line_column', 'left_sep_double', ' ',}
-- 	},
-- 	defaults={
-- 		-- bg="#181a23",
-- 		fg="#986fec",
-- 		cool_symbol = "  ",
-- 		left_separator = "",
-- 		right_separator = "",
-- 		line_column = "%l:%c [%L]"
-- 	},
-- 	mode_colors = {
-- 		n = "#181a23",
-- 		i = "#181a23",
-- 		ic= "#181a23",
-- 		c = "#181a23"
-- 	}
-- }

-- 	mode_colors = {
-- 		n = "#986fec",
-- 		i = "#e86671",
-- 		ic= "#e86671",
-- 		c = "#e27d60"
-- 	}
-- local leftSeparator = ""	-->      
-- local rightSeparator = ""	-->      

