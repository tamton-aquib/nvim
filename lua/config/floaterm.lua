
local map = vim.api.nvim_set_keymap
local exp = vim.fn.expand
local this = vim.api.nvim_get_current_buf
local noice = {noremap=true, silent=true}
Open_term = require'toggleterm.terminal'.Terminal

local border = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏"}

require("toggleterm").setup{
	size = 20,
	hide_numbers = true,
	start_in_insert = true,
	insert_mappings = true,
	shade_terminals = true,
	shading_factor = '3',
	persist_size = true,
	close_on_exit = false,
	direction = 'float',
	float_opts = {
		border = border,
		winblend = 30,
		highlights = {
			border = "Normal",
			background = "NormalFloat"
		}
	}
}
function Exec_cmd(cmd)
	Open_term:new{
		cmd = cmd,
		on_exit = function(t) t:shutdown() end
	}:toggle()
end

local files = {
	python	   = "python "..exp('%:t'),
	c		   = "gcc -o noice "..exp('%:t').."&& ./noice && rm ./noice",
	java	   = "javac "..exp('%:t').." && java "..exp('%:t:r').." && rm *.class",
	rust	   = "cargo run",
	javascript = "node "..exp('%:t'),
	typescript = "tsc "..exp('%:t').." && node "..exp('%:t:r')..".js",
}

map('n', '<leader>l', ':lua Exec_cmd("lazygit")<CR>', noice)
-- map('n', '<leader>p', ':lua Exec_cmd("python")<CR>', noice)
map('n', '<leader>t', ':lua Exec_cmd(nil)<CR>', noice)

function Run_file()
	local command = files[vim.bo.filetype]
	if command ~= nil then
		Open_term:new{cmd=command}:toggle()
		print("Running: "..command)
	end
end

vim.api.nvim_buf_set_keymap(this(), 'n', '<leader>r', [[:w<CR>:lua Run_file()<CR>]], noice)

