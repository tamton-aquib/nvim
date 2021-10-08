local M = {}

function M.indent_blankline()
	-- vim.g.indentLine_enabled = 1
	vim.g.indent_blankline_char = "▏"
	vim.g.indent_blankline_filetype_exclude = {
		"TelescopePrompt", "help", "terminal", "dashboard", "packer", "norg", "lspinfo"
	}
	vim.g.indent_blankline_buftype_exclude = {"terminal", "norg"}
end

function M.markdown_preview()
	vim.g.mkdp_refresh_slow = 1
	vim.g.mkdp_auto_close = 0
end

return M
