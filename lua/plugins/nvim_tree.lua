vim.g.nvim_tree_ignore = { '.git', 'node_modules', '.cache', '__pycache__' }
vim.g.nvim_tree_auto_ignore_ft = { 'dashboard', 'noiceboard' }
vim.g.nvim_tree_indent_markers = 1

local tree_cb = require'nvim-tree.config'.nvim_tree_callback

require "nvim-tree".setup {
	disable_netrw = true,
	hijack_netrw = true,
	quit_on_open = true,
	view = {
		mappings = {
			list = {
				{ key = "za", cb = tree_cb("edit") },
				{ key = "?", cb = tree_cb("toggle_help") },
			}
		}
	}
}
