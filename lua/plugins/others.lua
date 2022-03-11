local M = {}

function M.indent_blankline()
	require("indent_blankline").setup{
		char = "▏", -- 
		show_current_context = true,
		strict_tabs = true,
		filetype_exclude = {
			"TelescopePrompt", "help", "terminal", "dashboard", "NvimTree",
			"packer", "lspinfo", "lsp-installer"
		},
		buftype_exclude = { "terminal", "norg" }
	}
end

function M.markdown_preview()
	vim.g.mkdp_refresh_slow = 1
	vim.g.mkdp_auto_close = 0
end

return M
