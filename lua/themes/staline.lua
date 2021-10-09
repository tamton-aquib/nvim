--> staline setup
-- #181a23    
--          
-- local leftSeparator = ""	-->      
-- local rightSeparator = ""	-->      
local Styles = {}

require 'stabline'.setup {
	style = "slant",
	font_active = "bold,italic",
	-- stab_start = "%#Rocket#      ",
	stab_left = " ",
	stab_right = "  ",
	stab_start = "  ",
	bg = "#0e171c",
	-- fg = "#986fec",
	stab_bg = "#1e2127"
}

-- require 'stabline'.setup {
	-- style = "slant",
	-- font_active = "bold,italic",
	-- stab_start = "   ",
	-- -- stab_start = "%#Rocket#      ",
	-- bg = "#0e171c",
	-- stab_bg = "#211641",
	-- stab_left = " ",
	-- stab_right = "  ",
	-- fg = "#986fec",
	-- inactive_bg = "#211641"
-- }

-- vim.cmd [[hi Rocket guifg=#f36365 guibg=none gui=bold]]
-- vim.cmd [[hi Rocket guifg=#97c374 guibg=#1e1e1e gui=bold]]

Styles.simple_line = {
	sections = {
		-- left = { '  ', 'mode', ' ', 'branch', '      ', 'lsp', },
		left = { '  ', 'mode', ' ', 'branch', '     ', 'lsp' },
		mid = {'%<'},
		right = {'%l/%L  :%c  ', 'file_name', '  ',
			function()
				local current_line = vim.fn.line "."
				local total_lines = vim.fn.line "$"
				local chars = { "_", "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
				local line_ratio = current_line / total_lines
				local index = math.ceil(line_ratio * #chars)
				return chars[index]
			end, ' '
		},
		defaults = {
			bg = "#0e171c"
		}
	},
	-- mode_colors = {
		-- i = "#986fec",
		-- -- n = "#759a51",
		-- n = "#7aa2f7"
	-- },

	-- mode_colors = {
		-- n = "#986fec",
		-- i = "#e86671",
		-- ic= "#e86671",
		-- c = "#e27d60"
	-- },
	mode_colors = {
		-- n = "#38b1f0",
		-- i = "#9ece6a",       -- etc mode
		n = "#61afef",
		i = "#97c374",       -- etc mode
		ic= "#97c374",       -- etc mode
		c = "#c94f6d",
	},
	defaults = {
		true_colors = true,
		line_column = " [%l/%L] :%c  ",
		branch_symbol = " ",
	}
}

Styles.evil_line = {
	sections = {
		left = {
			'▊', '  ',
			{ 'Evil', '  ' },
			' ',       -- The mode and evil sign
			'file_size', ' ',                         -- Filesize
			{ 'StalineFile', 'file_name' },
			' ', 'lsp'
		},
		mid = { 'lsp_name' },                         -- "lsp_name" is still a little buggy
		right = {
			{ 'StalineGit', ' %l/%L :%c  '},
			{ 'StalineEnc', vim.bo.fileencoding:upper() }, '  ',  -- Example for custom section
			{ 'StalineEnc', 'cool_symbol' }, ' ',                 -- the cool_symbol for your OS
			{ 'StalineGit', 'branch' }, ' ',
			function()
				local current_line = vim.fn.line "."
				local total_lines = vim.fn.line "$"
				local chars = { "_", "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
				local line_ratio = current_line / total_lines
				local index = math.ceil(line_ratio * #chars)
				return chars[index]
			end
		}
	},
	defaults = {
		-- bg = "#202020",
		bg = "#202328",
		branch_symbol = " ",
		true_colors = true,
		font_active = "bold"
	},
	mode_colors = {
		-- n = "#38b1f0",
		-- i = "#9ece6a",       -- etc mode
		n = "#61afef",
		i = "#97c374",       -- etc mode
		ic= "#97c374",       -- etc mode
		c = "#c94f6d",
	}
}

vim.cmd [[hi Evil        guifg=#f36365 guibg=#202328]]             -- Higlight for Evil symbol
vim.cmd [[hi StalineEnc  guifg=#7d9955 guibg=#202328]]       -- Encoding Highlight
vim.cmd [[hi StalineGit  guifg=#8583b3 guibg=#202328]]       -- Branch Name Highlight
vim.cmd [[hi StalineFile guifg=#c37cda guibg=#202328]]      -- File name Highlight

Styles.atom_line = {
	sections = {
		left = {' ', '', '-   ', {'FileNameHighlight', 'file_name'}, {'FileNameRightSepHighlight',''}, 'branch' },
		mid = {'-lsp'},
		right = {
			'', '-mode', {'FileNameHighlight', 'line_column'},
			{'FileNameHighlight'," ".. os.date("%I:%M").." "},
			{'FileNameRightSepHighlight',''}, '  '
		},
	},
	defaults = {
		font_active = "bold,italic",
		branch_symbol = " ",
		true_colors = true,
		line_column = " %l/%L :%c "
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
-- ;#a3be8c

Styles.normal_line = {
	sections = {
		left = {
			{ 'StalineFill', ' ' },
			{ 'StalineFill', 'mode' },
			{ 'left_sep_double'},
			{ ' ' },
			{ 'branch' },
			{ 'cool_symbol' }
		},
		mid = {
			{ 'file_name' },
			{ 'lsp' }
		},
		right = {
			{ vim.bo.fileencoding },
			{ '  ' },
			{ 'right_sep_double' },
			{ 'StalineFill', 'line_column' }
		}
	},
	defaults = {
		cool_symbol = "  ",
		left_separator = "",
		right_separator = "",
		bg = "#202328",
		full_path = false,
		branch_symbol = " "
	},
	mode_colors = {
		n = "#986fec",
		i = "#e86671",
		ic= "#e86671",
		c = "#e27d60"
		-- n = "#dddddd",
		-- i = "#dddddd",
		-- ic= "#dddddd",
		-- c = "#dddddd"
	}
}

Styles.pebble_line = {
	sections = {
		left = {
			' ', 'right_sep_double', '-mode', 'left_sep_double', ' ',
			'right_sep', '-file_name', 'left_sep', ' ',
			'right_sep_double', '-branch', 'left_sep_double', ' ',
		},
		mid  = {'lsp'},
		right= {
			'right_sep', '-cool_symbol', 'left_sep', ' ',
			'right_sep', '- ', '-lsp_name', '- ', 'left_sep',
			'right_sep_double', '-line_column', 'left_sep_double', ' ',
		}
	},

	defaults={
		fg = "#986fec",
		cool_symbol = "  ",
		left_separator = "",
		right_separator = "",
		-- line_column = "%l:%c [%L]",
		true_colors = true,
		line_column = "[%l:%c] 並%p%% "
		-- font_active = "bold"
	},
	mode_colors = {
		n  = "#181a23",
		i  = "#181a23",
		ic = "#181a23",
		c  = "#181a23",
		v  = "#181a23"       -- etc
	}
}

require("staline").setup(Styles.pebble_line)
--vim:set foldlevelstart=0, set foldenable
