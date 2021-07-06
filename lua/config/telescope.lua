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

vim.api.nvim_set_keymap(
	'n',
	'<leader>f',
	[[:lua require('telescope.builtin').find_files(require'telescope.themes'.get_dropdown({previewer=false}))<CR>]]
	, {noremap = true, silent = true}
)
