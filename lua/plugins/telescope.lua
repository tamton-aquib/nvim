
require('telescope').setup{
	defaults = {
		vimgrep_arguments = {
			-- 'rg', '--color=never', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'
			'rg', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'
		},
		prompt_prefix = "   ",
		selection_caret = " ",
		entry_prefix = "  ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_strategy = "vertical",
		layout_config = {
			horizontal = {
				mirror = false,
			},
			vertical = {
				mirror = true,
			},
		},
		file_ignore_patterns = {'__pycache__', 'node_modules'},
		winblend = 0,
		border = {},

		use_less = true,
		path_display = {},
		set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
	}
}
