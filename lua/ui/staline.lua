--> staline setup
--            
-- local leftSeparator = ""	-->        
-- local rightSeparator = ""	-->        
local Styles = {}

local gruvbox = {
    n = "#a89985",
    i = "#84a598",
    c = "#8fbf7f",
    v = "#fc802d",
    V = "#fc802d",
}

require('stabline').setup {
	style = "slant",
	stab_start = "   ",
	font_active = "bold,italic",
	inactive_bg = "#191817",
}

Styles.simple_line = {
	sections = {
		left = {
			'  ', 'mode', ' ', 'branch',
			function()
				if vim.o.columns > 100 then
					return '     '
				end
				return ''
			end
		},
		mid = { 'lsp', '%<'},
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
	mode_colors = gruvbox,

	defaults = {
		true_colors = true,
		line_column = " [%l/%L] :%c  ",
		branch_symbol = " ",
	}
}

Styles.pebble_line = {
	sections = {
		left = {
			' ', 'right_sep_double', '-mode', 'left_sep_double', ' ',
			'right_sep', '-file_name', 'left_sep', ' ',
			function()
				local head = vim.g.gitsigns_head or ""
				return (head ~= nil or head ~= "") and unpack({"   "..head}) or ""
			end,
		},
		mid = { 'lsp' },
		right= {
			'right_sep', '-cool_symbol', 'left_sep', '%< ',
			'right_sep', '- ', '-lsp_name', '- ', 'left_sep', ' ',
			'right_sep_double', '-line_column', 'left_sep_double', ' ',
		}
	},

	defaults={
		cool_symbol = "  ",
		left_separator = "",
		right_separator = "",
		true_colors = true,
		line_column = "[%l:%c] 並%p%% "
	},
	mode_colors = gruvbox
}

require("staline").setup(Styles.pebble_line)
