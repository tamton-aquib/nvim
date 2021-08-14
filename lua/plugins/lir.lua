local actions = require'lir.actions'
local mark_actions = require 'lir.mark.actions'
local clipboard_actions = require'lir.clipboard.actions'

require'lir'.setup {
	show_hidden_files = false,
	devicons_enable = true,
	mappings = {
		['l']     = actions.edit,
		['o']     = actions.edit,
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
		winblend = 30,

		-- You can define a function that returns a table to be passed as the third
		-- argument of nvim_open_win().
		win_opts = function()
		  return {
		    border = require("lir.float.helper").make_border_opts({
		      -- "+", "─", "+", "│", "+", "─", "+", "│",
			  "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏"
		    }, "Normal"),
		  }
		end,
	},
	hide_cursor = false,
}

vim.api.nvim_set_keymap('n', '<leader>n', "<cmd>lua require'lir.float'.toggle()<CR>", {noremap=true, silent=true})

