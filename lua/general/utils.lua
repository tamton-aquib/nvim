Util = {}

Util.close_command = function()
	local total = 0
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_is_valid(buf) then
			total = total + 1
		end
	end

	vim.cmd(total == 1 and ":q" or ":bd")
end


local borders = {
	{ "╒", "═", "╕", "│", "╛", "═", "╘", "│" },
	{ "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" },
	{ "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
}

Util.border = borders[1]

Util.telescope_theme = {
	theme = "noice",
	sorting_strategy = "ascending",
	results_title = false,
	layout_strategy = "center",
	previewer = false,
	winblend = 45,

	layout_config = {
		preview_cutoff = 2, -- Preview should always show (unless previewer = false)
		width = 0.6,
		height = 0.5
	},

	border = true,
	borderchars = {
		-- results = { "─", " ", " ", " ", "╰", "╯", " ", " " },
		-- prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		prompt = { "═", "│", "═", "│", "╒", "╕", "╛", "╘" },
		results = { "═", " ", " ", " ", "╘", "╛", " ", " " },
	},
}

return Util
