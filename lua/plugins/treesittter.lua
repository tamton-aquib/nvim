require('nvim-treesitter.configs').setup {
	ensure_installed = { "norg" ,"lua", "comment" },
	highlight = {
		enable = true,
	},
	indent = {
		enable = true
	},
}
