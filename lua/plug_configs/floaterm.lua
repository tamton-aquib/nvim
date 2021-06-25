
local map = vim.api.nvim_buf_set_keymap
local exp = vim.fn.expand
local this = vim.api.nvim_get_current_buf
local noice = {noremap=true, silent=true}
open_term = require'toggleterm.terminal'.Terminal

require("toggleterm").setup{
	size = 20,
	hide_numbers = true,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	close_on_exit = false,
	direction = 'float',
	float_opts = {
		border = 'single',
		winblend = 5,
	}
}
function Exec_cmd(cmd)
	open_term:new{
		cmd = cmd,
		on_exit = function(t) t:shutdown() end
	}:toggle()
end

local files = {
	python	   = "python "..exp('%:t'),
	c		   = "gcc -o noice "..exp('%:t').."&& ./noice && rm ./noice",
	java	   = "javac "..exp('%:t').." && java "..exp('%:t:r').." && rm *.class",
	rust	   = "cargo run",
	javascript = "node "..exp('%:t')
}

map(this(), 'n', '<leader>l', ':lua Exec_cmd("lazygit")<CR>', noice)
map(this(), 'n', '<leader>p', ':lua Exec_cmd("python")<CR>', noice)
map(this(), 'n', '<leader>t', ':lua open_term:new{}:toggle()<CR>', noice)

function Run_file()
	local command = files[vim.bo.filetype]
	if command ~= nil then
		open_term:new{cmd=command}:toggle()
		print("Running: "..command)
	end
end

map(this(), 'n', '<leader>r', [[:w<CR>:lua Run_file()<CR>]], noice)

