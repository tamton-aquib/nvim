
local map = vim.api.nvim_set_keymap
local exp = vim.fn.expand
local this = vim.api.nvim_get_current_buf
local noice = {noremap=true, silent=true}
Open_term = require'toggleterm.terminal'.Terminal

require("toggleterm").setup{
	hide_numbers = true,
	start_in_insert = true,
	insert_mappings = true,
	-- open_mapping = [[<leader>t]],
	shade_terminals = true,
	shading_factor = '3',
	persist_size = true,
	close_on_exit = false,
	direction = 'float',
	float_opts = {
		border = require"general.utils".border,
		winblend = 30,
		highlights = {
			border = "FloatBorder",
			background = "NormalFloat"
		}
	}
}

map('n', '<leader>l', ':lua Open_term:new{cmd="lazygit", close_on_exit=true}:toggle()<CR>', noice)
map('n', '<leader>t', ':lua Open_term:new{cmd=nil, close_on_exit=true, count=5}:toggle()<CR>', noice)

local files = {
	python	   = "python "..exp('%:t'),
	c		   = "gcc -o noice "..exp('%:t').." && ./noice && rm ./noice",
	java	   = "javac "..exp('%:t').." && java "..exp('%:t:r').." && rm *.class",
	rust	   = "cargo run",
	javascript = "npm start",
	sh         = "bash "..exp('%:p')
}

function Run_file()
	local command = files[vim.bo.filetype]
	if command ~= nil then
		Open_term:new{ cmd=command, close_on_exit = false, }:toggle()
		print("Running: "..command)
	end
end

vim.api.nvim_buf_set_keymap(this(), 'n', '<leader>r', [[:w<CR>:lua Run_file()<CR>]], noice)

