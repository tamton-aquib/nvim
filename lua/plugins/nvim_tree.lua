vim.g.nvim_tree_ignore = { '.git', 'node_modules', '.cache', '__pycache__' }
vim.g.nvim_tree_auto_ignore_ft = { 'dashboard', 'noiceboard' }
vim.g.nvim_tree_quit_on_open = 1
vim.g.nvim_tree_indent_markers = 1

local tree_cb = require'nvim-tree.config'.nvim_tree_callback

require "nvim-tree".setup {
	hijack_netrw = true,
	view = {
		mappings = {
			list = {
				{ key = "za", cb = tree_cb("edit") },
				{ key = "?", cb = tree_cb("toggle_help") },
			}
		}
	}
}
