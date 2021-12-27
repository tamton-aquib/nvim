--> Noice icons:           
--> left_sep   :          
--> right_sep  :          
--> TODO: cleanup
local Styles = {}

require('stabline').setup {
	style = "bar",
	stab_left = "",
	-- stab_right = "",
	fg = "#986fec",
	inactive_bg = "none",
	padding = 2
}

Styles.simple_line = {

	sections = {
		left = {

			'  ', 'mode', ' ',
			'branch',

			function()
				if vim.api.nvim_win_get_width(0) > 100 then
					return os.getenv("TERM") == "alacrtty" and '    ' or '   '
				end
				return ''
			end,
			'lsp'
		},
		mid = {
			'file_name',
			'%<',
		},
		right = { '%l/%L  :%c  ',
			function()
				return " "..os.date("%I:%M %P")
			end,
			'  ',
			function()
				local current_line = vim.fn.line "."
				local total_lines = vim.fn.line "$"
				local chars = { "_", "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
				local line_ratio = current_line / total_lines
				local index = math.ceil(line_ratio * #chars)
				return chars[index]
			end, ' '
		},
	},
	mode_colors = { n = "#94c461" },

	defaults = {
		true_colors = true,
		line_column = " [%l/%L] :%c  ",
		branch_symbol = " ",
		-- bg = "#11121d"
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

	defaults = {
		cool_symbol = "  ",
		left_separator = "",
		right_separator = "",
		true_colors = true,
		line_column = "[%l:%c] 並%p%% ",
		mod_symbol = "nice"
	},
	mode_colors = {
		n = "#94c461",
		i = "#94c461",
		ic = "#94c461",
		v = "#94c461",
	}
}

require("staline").setup(Styles.simple_line)
