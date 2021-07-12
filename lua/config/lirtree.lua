local actions = require'lir.actions'
local mark_actions = require 'lir.mark.actions'
local clipboard_actions = require'lir.clipboard.actions'

require 'lir'.setup {
	show_hidden_files = false,
	devicons_enable = true,
	mappings = {
	['l']     = actions.edit,
	['<C-s>'] = actions.split,
	['<C-v>'] = actions.vsplit,
	['<C-t>'] = actions.tabedit,

	['h']     = actions.up,
	['q']     = actions.quit,

	['K']     = actions.mkdir,
	['N']     = actions.newfile,
	['R']     = actions.rename,
	['@']     = actions.cd,
	['Y']     = actions.yank_path,
	['.']     = actions.toggle_show_hidden,
	['D']     = actions.delete,

	['J'] = function()
		mark_actions.toggle_mark()
		vim.cmd('normal! j')
	end,
	['C'] = clipboard_actions.copy,
	['X'] = clipboard_actions.cut,
	['P'] = clipboard_actions.paste,
	},
	float = {
		winblend = 15,
	},
	hide_cursor = false,
}

vim.api.nvim_set_keymap('n', '<leader>n', ":lua require'lir.float'.toggle()<CR>", {noremap=true, silent=true})
vim.cmd [[hi LirDir guifg=#7ebae4]]
