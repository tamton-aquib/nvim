--> staline setup
-- #181a23    
require'stabline'.setup {
	style = "slant",
	bg = "#181a23",
	fg = "#986fec",
	stab_bg = "none",
	stab_right = "",
	stab_left = ""
}

-- require'stabline'.setup {
	-- style = 'bar',
	-- font_active = "bold,italic",
	-- font_inactive = "italic",
	-- -- bg = "#ff6077",
	-- -- fg = "#414550",
	-- fg = "#986fec",
	-- -- stab_bg = "none",
	-- start = "%#BranchGreen#    ",
	-- -- stab_right = ""
	-- -- inactive_bg = "none"
	-- -- bg = "#181a23",
	-- -- bg = "#7741e6",
-- }
vim.cmd [[hi BranchGreen guifg=#2bbb4f ]]
--'right_sep', {'LspDiagnosti csSignError', '   '}, 'left_sep',

-- require 'staline'.setup {
	-- sections = {
		-- left = {' ', '', '-   ', {'FileNameHighlight', 'filename'}, {'FileNameRightSepHighlight',''}, 'branch' },
		-- mid = {'-lsp'},
		-- right = {'', '-mode', {'FileNameHighlight', 'line_column'}, {'FileNameRightSepHighlight',''}, '  ' },
	-- },
	-- defaults = {
		-- font_active = "bold,italic",
		-- branch_symbol = " ",
		-- true_colors = true,
	-- },
	-- mode_icons = {
		-- n = "NORMAL"
	-- },
	-- mode_colors = {
		-- -- n = "#e95678",
		-- n = "#986fec",
		-- i = "#9ece6a",
		-- ic= "#9ece6a"
	-- }
-- }
--
-- vim.cmd [[hi FileNameHighlight guifg=white guibg=#393b4d]]
-- vim.cmd [[hi FileNameRightSepHighlight guifg=#393b4d]]
-- ;#a3be8c
-- require'staline'.setup{
	-- sections = {
		-- left = {'- ', '-mode', 'left_sep_double', 'filename', '  ', 'branch'},
		-- mid  = {'lsp'},
		-- right= { 'cool_symbol', '  ', vim.bo.fileencoding, 'right_sep_double', '-line_column'}
	-- },
	-- defaults = {
		-- cool_symbol = "  ",
		-- left_separator = "",
		-- right_separator = "",
		-- bg = "#303030",
		-- full_path = false,
		-- branch_symbol = " "
	-- },
	-- mode_colors = {
		-- n = "#986fec",
		-- i = "#e86671",
		-- ic= "#e86671",
		-- c = "#e27d60"
	-- }
-- }

require'staline'.setup{
	sections = {
		left = {
			' ', 'right_sep_double', '-mode', 'left_sep_double', ' ',
			'right_sep', '-filename', 'left_sep', ' ',
			'right_sep_double', '-branch', 'left_sep_double', ' ',},
		mid  = {'lsp'},
		right= {
			'right_sep', '-cool_symbol', 'left_sep', ' ',
			'right_sep', '-  ', '-lsp_name', '- ', 'left_sep',
			'right_sep_double', '-line_column', 'left_sep_double', ' ',}
	},
	defaults={
		-- bg="#181a23",
		fg="#986fec",
		cool_symbol = "  ",
		left_separator = "",
		right_separator = "",
		-- line_column = "%l:%c [%L]",
		true_colors = true
	},
	mode_colors = {
		n = "#181a23",
		i = "#181a23",
		ic= "#181a23",
		c = "#181a23"
	}
}

-- 	mode_colors = {
-- 		n = "#986fec",
-- 		i = "#e86671",
-- 		ic= "#e86671",
-- 		c = "#e27d60"
-- 	}
-- local leftSeparator = ""	-->      
-- local rightSeparator = ""	-->      

