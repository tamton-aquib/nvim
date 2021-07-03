-- borderchars = { '═', '║', '═', '║', '╔', '╗', '╝', '╚' },
require('telescope').setup{
	defaults = {
		prompt_prefix = "   ",
		selection_caret = "❱ ",
		entry_prefix = "  ",
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
	}
}
