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
	if vim.api.nvim_buf_is_valid(0) and vim.api.nvim_buf_is_loaded(0) then
		-- print("enetered a buffer with: "..vim.bo.ft)
		add_highlight_table(T.lang[ft] or {})
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

	vim.cmd [[au BufEnter,FileType * :lua require"custom.noice_dark".Lang_high(vim.bo.ft)]]
	set_hl_ns(ns)
end

return M
