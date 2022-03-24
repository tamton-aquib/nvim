--> Noice icons:             ⌬
--> left_sep   :          
--> right_sep  :          
--> toggle on-off icons just in case:  
--> TODO: cleanup
local Styles = {}

require('stabline').setup {
	style = "bar",
	stab_left = "",
	-- stab_right = "",
	fg = "#986fec",
	bg = "none",
	inactive_bg = "none",
	padding = 2
}

Styles.simple_line = {

	sections = {
		left = { '  ', 'mode', ' ', 'branch', '  ⌬  ', 'lsp' },
		mid = { 'file_name', '%<', },
		right = {
			function() return vim.b.bookmark_toggled or "" end,
			'    %l/%L  :%c  ',
			'  ',
			function()
				local chars = { "_", "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
				local line_ratio = vim.fn.line(".") / vim.fn.line("$")
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
	}
}

require("staline").setup(Styles.simple_line)
