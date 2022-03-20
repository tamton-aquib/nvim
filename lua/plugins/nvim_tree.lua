vim.g.nvim_tree_indent_markers = 1

require "nvim-tree".setup {
	disable_netrw = true,
	hijack_netrw = true,
	-- quit_on_open = true,
	ignore_ft_on_startup = {'dashboard', 'noiceboard'},
	filters = {
		custom = { '.git', 'node_modules', '.cache', '__pycache__' }
	},
	view = {
		mappings = {
			list = {
				{ key = "za", action = "edit" },
				{ key = "?", action = "toggle_help" }
			}
		}
	}
}
