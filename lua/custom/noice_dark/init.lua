M = {}
local cmd = vim.api.nvim_command
local T = require 'custom.noice_dark.noice_palette'

local ns = vim.api.nvim_create_namespace('noice_dark')
local set_hl_ns = vim.api.nvim__set_hl_ns or vim.api.nvim_set_hl_ns

local function add_highlight_table(tbl)
	for hl_grp, hl_value in pairs(tbl) do
		vim.api.nvim_set_hl(ns, hl_grp, hl_value)
	end
end

function M.Lang_high(ft)
	add_highlight_table(T.lang[ft] or {})
end

function M.check_change()
	if vim.g.colors_name ~= "noice" then
		print("Color changed")
		vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
	end
end

local function init_clear()
	cmd 'highlight clear'
	if vim.fn.exists("syntax_on") then cmd'syntax reset' end
	vim.g.colors_name = "noice"
	cmd("au BufEnter FileType markdown setlocal conceallevel=3 | syntax match markdownItalicDelimiter contained '*'")
end

function M.noice()
	init_clear()

	for _, tbl in pairs(T.Usual) do add_highlight_table(tbl) end
	for _, tbl in pairs(T.Plugins) do add_highlight_table(tbl) end

	local bg = T.back or "none"
	vim.cmd('hi Normal guibg='..bg..' guifg=#dddddd')
	set_hl_ns(ns)

	vim.cmd [[au BufEnter,WinEnter FileType * :lua require"custom.noice_dark".Lang_high(vim.bo.ft)]]
	vim.cmd [[au Colorscheme,ColorschemePre * lua require"custom.noice_dark".check_change()]]
end

return M
