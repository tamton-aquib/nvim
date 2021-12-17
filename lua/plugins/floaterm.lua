local map = vim.api.nvim_set_keymap
local noice = {noremap=true, silent=true}
Open_term = require'toggleterm.terminal'.Terminal -- NOTE: yes its intentionally global :kek:

require("toggleterm").setup{
	hide_numbers = true,
	start_in_insert = true,
	insert_mappings = true,
	shade_terminals = false,
	-- shading_factor = '0',
	persist_size = true,
	close_on_exit = false,
	direction = 'float',
	float_opts = {
		border = require"general.utils".border,
		winblend = 15,
		highlights = {
			border = "FloatBorder",
			background = "NormalFloat"
		}
	}
}

map('n', '<leader>l', ':lua Open_term:new{cmd="lazygit", close_on_exit=true}:toggle()<CR>', noice)
map('n', '<leader>t', ':lua Open_term:new{cmd=nil, close_on_exit=true, count=5}:toggle()<CR>', noice)
