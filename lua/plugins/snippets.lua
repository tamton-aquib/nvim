vim.cmd [[packadd LuaSnip]]
local ls = require'luasnip'
local map = vim.api.nvim_set_keymap
local opts = {noremap = true, expr=true}
local parse = ls.parser.parse_snippet

local html_bp = [[
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta name="author" content="tamton-aquib">
	<title>${1:TITLE}</title>
	<link type="text/css" rel="stylesheet" href="${2:style.css}">
</head>

<body>
	${0}

	<script src="${3:noice.js}"></script>
</body>

</html>
]]

local shebang = "#!/usr/bin/env python3\n"

local f_name = vim.fn.expand('%:t:r')
local react_rfc = [[
import React from 'react';

const ]]..f_name..[[ = (${1}) => {
	return (
		${0}
	);
}

export default ]]..f_name

local high = [[
${1:HighlightGroup} = { fg = "${2}", bg = "${3}" },${0}
]]

ls.snippets = {
	all = {
		parse({trig="html", wordTrig=true}, html_bp),
		parse({trig="#!", wordTrig=true}, shebang),
		parse({trig="rfc", wordTrig=true}, react_rfc),
		parse({trig="high", wordTrig=true}, high),
		parse({trig="conso", wordTrig=true}, [[console.log(${0})]])
	}
}

map('i','<Tab>', "luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'", opts)
map('i','<C-E>', "luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'", opts)

