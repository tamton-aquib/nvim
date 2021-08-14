
-- local border = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" }

require('telescope').setup{
	defaults = {
		vimgrep_arguments = {
			'rg',
			'--color=never',
			'--no-heading',
			'--with-filename',
			'--line-number',
			'--column',
			'--smart-case'
		},
		prompt_prefix = "    ",
		selection_caret = "❱ ",
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
		file_sorter =  require'telescope.sorters'.get_fuzzy_file,
		file_ignore_patterns = {'__pycache__', 'node_modules'},
		generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
		winblend = 30,
		border = {},
		borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },

		-- borderchars = { "▔", "▕", "▁", "▏", "🭽", "🭾", "🭿", "🭼" },
		color_devicons = true,
		use_less = true,
		path_display = {},
		set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
		file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
		grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
		qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

		-- Developer configurations: Not meant for general override
		buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
	}
}

vim.api.nvim_set_keymap(
	'n',
	'<leader>f',
	[[:lua require('telescope.builtin').find_files(require'telescope.themes'.get_cursor({previewer=false}))<CR>]]
	, {noremap = true, silent = true}
)
vim.api.nvim_set_keymap(
	'n',
	'<leader>g',
	[[:lua require('telescope.builtin').live_grep(require'telescope.themes'.get_cursor({previewer=false}))<CR>]]
	, {noremap = true, silent = true}
)
vim.api.nvim_set_keymap('n', '<leader>h', ':Telescope help_tags<CR>', {noremap=true, silent=true})
