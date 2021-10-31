local M = {}

function M.indent_blankline()
	-- vim.g.indentLine_enabled = 1
	vim.g.indent_blankline_char = "▏"
	-- vim.g.indent_blankline_char = ""
	vim.g.indent_blankline_filetype_exclude = {
		"TelescopePrompt", "help", "terminal", "dashboard", "NvimTree",
		"packer", "lspinfo", "lsp-installer"
	}
	vim.g.indent_blankline_buftype_exclude = {"terminal", "norg"}
end

function M.specs()
	vim.cmd [[hi Specs guibg=#ffffff]]
	require('specs').setup{
		show_jumps  = true,
		min_jump = 1,
		popup = {
			delay_ms = 0, -- delay before popup displays
			inc_ms = 10, -- time increments used for fade/resize effects
			blend = 50, -- starting blend, between 0-100 (fully transparent), see :h winblend
			width = 8,
			winhl = "Specs",
			fader = require('specs').empty_fader,
			resizer = require('specs').shrink_resizer
		},
		ignore_filetypes = {},
		ignore_buftypes = {
			nofile = true,
		},
	} -- aiuwhefawefjasdfasdf
end

function M.markdown_preview()
	vim.g.mkdp_refresh_slow = 1
	vim.g.mkdp_auto_close = 0
end

return M
