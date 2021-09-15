M = {}

function M.indent_blankline()
	-- vim.g.indentLine_enabled = 1
	vim.g.indent_blankline_char = "▏"
	vim.g.indent_blankline_filetype_exclude = { "TelescopePrompt", "help", "terminal", "dashboard", "packer", "norg"}
	vim.g.indent_blankline_buftype_exclude = {"terminal", "norg"}
end

function M.markdown_preview()
	vim.g.mkdp_refresh_slow = 1
	vim.g.mkdp_auto_close = 0
end

function M.femboyf()
	require('femboyf').setup {
		-- These are all optional
		-- change the defaults here:

		-- When to highlight?
		-- 'always'             always in normal and visual mode (default)
		-- 'onkeypress'         only when f,F,t,T are pressed (not implemented yet)
		when = 'always',

		-- How to highlight?
		-- '1perword':          1 character per word (default)
		-- 'line':              all possible characters in a line
		style = '1perword',

		-- What colors to use? #HEX / default vim colors
		color1 = '#986fec',
		color2 = '#986fec',
	}
end

return M
