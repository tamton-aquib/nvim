vim.g.nvim_tree_ignore = { '.git', 'node_modules', '.cache' }
-- vim.g.nvim_tree_auto_open = 1
vim.g.nvim_tree_auto_ignore_ft = { 'dashboard', 'noiceboard' }
vim.g.nvim_tree_quit_on_open = 1

local tree_cb = require'nvim-tree.config'.nvim_tree_callback

-- vim.api.nvim_set_keymap('n', '<leader>n', ":NvimTreeToggle<CR>", {noremap=true, silent=true})

require "nvim-tree".setup {
	view = {
		mappings = {
			list = {
				{ key = "za", cb = tree_cb("edit") },
				{ key = "?", cb = tree_cb("toggle_help") },
			}
		}
	}
}
