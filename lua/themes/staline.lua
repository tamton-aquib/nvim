--> staline setup
-- #181a23    
require'stabline'.setup {
	style = "slant",
	-- bg = "#1e2127",
	-- fg = "#986fec",
	-- stab_bg = "none",
	font_active = "none",
	-- exclude_fts = {'NvimTree', 'dashboard', 'packer', 'lir'},
	stab_left = " ",
	stab_right = " "
	-- inactive_bg = "#282c34"
}
-- 
require"staline".setup {
	sections = {
		left = {
			'▊', '   ', { 'Evil', '  ' }, ' ',         -- The mode and evil sign
			'file_size', ' ',                      -- Filesize
			{ 'StalineFile', 'file_name' }, ' '       -- Filename in different highlight
		},
		mid = { 'lsp_name' },                  -- "lsp_name" is still a little buggy
		right = {
			{ 'StalineEnc', vim.bo.fileencoding:upper() }, '  ',  -- Example for custom section
			{ 'StalineEnc', 'cool_symbol' }, ' ',                 -- the cool_symbol for your OS
			{ 'StalineGit', 'branch' }, ' ', '▊'                  -- Branch Name in different highlight
		}
	},
	defaults = {
		bg = "#202328",
		branch_symbol = " "
	},
	mode_colors = {
		-- n = "#38b1f0",
		-- i = "#9ece6a",       -- etc mode
		n = "#a89985",
		i = "#84a598",
		c = "#8fbf7f",
		v = "#fc802d",
	}
}
vim.cmd [[hi Evil        guifg=#f36365 guibg=#202328]]             -- Higlight for Evil symbol
vim.cmd [[hi StalineEnc  guifg=#7d9955 guibg=#202328]]       -- Encoding Highlight
vim.cmd [[hi StalineGit  guifg=#8583b3 guibg=#202328]]       -- Branch Name Highlight
vim.cmd [[hi StalineFile guifg=#c37cda guibg=#202328]]      -- File name Highlight

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
-- vim.cmd [[hi BranchGreen guifg=#2bbb4f ]]
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

vim.cmd [[hi FileNameHighlight guifg=white guibg=#393b4d]]
vim.cmd [[hi FileNameRightSepHighlight guifg=#393b4d]]
-- ;#a3be8c

-- require'staline'.setup{
	-- sections = {
		-- left = {'- ', '-mode', 'left_sep_double', 'filename', '  ', 'branch'},
		-- mid  = {'lsp'},
		-- right= { {'ArchSymbol', 'cool_symbol'}, '  ', vim.bo.fileencoding:upper(), 'right_sep_double', '-line_column'}
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
		-- -- n = "#986fec",
		-- -- i = "#e86671",
		-- -- ic= "#e86671",
		-- -- c = "#e27d60"
		-- n = "#dddddd",
		-- i = "#dddddd",
		-- ic= "#dddddd",
		-- c = "#dddddd"
	-- }
-- }

-- require'staline'.setup{
	-- sections = {
		-- left = {
			-- ' ', 'right_sep_double', '-mode', 'left_sep_double', ' ',
			-- 'right_sep', '-filename', 'left_sep', ' ',
			-- 'right_sep_double', '-branch', 'left_sep_double', ' ',},
		-- mid  = {'lsp'},
		-- right= {
			-- 'right_sep', '-cool_symbol', 'left_sep', ' ',
			-- 'right_sep', '-  ', '-lsp_name', '- ', 'left_sep',
			-- 'right_sep_double', '-line_column', 'left_sep_double', ' ',}
	-- },
	-- defaults={
		-- -- bg="#181a23",
		-- fg="#986fec",
		-- cool_symbol = "  ",
		-- left_separator = "",
		-- right_separator = "",
		-- -- line_column = "%l:%c [%L]",
		-- true_colors = true,
		-- -- font_active = "bold"
	-- },
	-- mode_colors = {
		-- n = "#181a23",
		-- i = "#181a23",
		-- ic= "#181a23",
		-- c = "#181a23"
	-- }
-- }

-- 	mode_colors = {
-- 		n = "#986fec",
-- 		i = "#e86671",
-- 		ic= "#e86671",
-- 		c = "#e27d60"
-- 	}
-- local leftSeparator = ""	-->      
-- local rightSeparator = ""	-->      

