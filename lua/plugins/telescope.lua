require('telescope').setup{
	defaults = {
		vimgrep_arguments = {
			'rg', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'
		},
		prompt_prefix = "   ",
		selection_caret = " ",
		entry_prefix = "  ",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		layout_config = {
			horizontal = { mirror = false },
			vertical = { mirror = false },
		},
		file_ignore_patterns = {'__pycache__', 'node_modules'},
		winblend = 0,
		path_display = {},
		set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
	}
}
