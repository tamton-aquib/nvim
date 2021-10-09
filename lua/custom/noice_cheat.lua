local M = {}
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")

function M.getword()
	local nice_word = vim.trim(vim.fn.getline('.'))
	vim.cmd [[q]]

	local noice = vim.fn.join(vim.split(nice_word, " "), "+")
	require "toggleterm.terminal".Terminal:new{
		cmd=('curl cht.sh/%s/%s'):format(M.lang, noice),
		float_opts = { border='double' },
		on_open = function(term)
			vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
			vim.cmd [[stopinsert!]]
		  end,
	}:toggle()
end

local function tiny_window()
	local buf = vim.api.nvim_create_buf(false, true)

	local height, width = vim.o.lines, vim.o.columns
    local w = math.ceil(width * 0.7)
    local row = math.ceil((height) / 2 - 3)
    local col = math.ceil((width - w) / 2)
	vim.api.nvim_open_win(buf, true, {
		relative='win', row=row, col=col, width=w, height=1, style='minimal', border='rounded'
	})
	vim.api.nvim_buf_set_keymap(0, 'i', '<CR>', '<cmd>lua require("custom.noice_cheat").getword()<CR>', {noremap=true})
	vim.api.nvim_feedkeys('i', 'n', true)
end

M.cheat = function()
	pickers.new(require("telescope.themes").get_cursor{}, {
		prompt_title = "Langs",
		finder = finders.new_table({'rust', 'python', 'c', 'cpp', 'javascript', 'lua'}),
		sorter = conf.generic_sorter({}),
		attach_mappings = function(_, map)
			map("i", "<cr>", function(prompt_bufnr)
				M.lang = action_state.get_selected_entry()['value']
				actions.close(prompt_bufnr)
				tiny_window()
			end)
			return true
		end,
	}):find()
end

return M
