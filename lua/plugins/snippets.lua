local ls = require'luasnip'
local parse = ls.parser.parse_snippet
local d = ls.dynamic_node

local hash_include = [[
#include<stdio.h>
#include<stdlib.h>

int main() {
	${0:Noice}
}
]]

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


local prints = {
	rust = [[println!("{${0}}");]],
	python = [[print(${0})]],
	javascript = [[console.log(${0});]],
	lua = [[print(${0})]],
	c = [[printf("${0}");]]
}

ls.snippets = {
	-- all = {
		-- parse({trig="pp", wordTrig=true}, prints[vim.bo.ft] or ""),
	-- },

	python = {
		parse({trig="#!", wordTrig=true}, "#!/usr/bin/env python3\n"),
		parse({trig="pp", wordTrig=true}, prints.python),
	},
	rust = {
		parse({trig="pp", wordTrig=true}, prints.rust),
	},
	lua = {
		parse({trig="pp", wordTrig=true}, prints.lua),
	},
	javascript = {
		parse({trig="pp", wordTrig=true}, prints.javascript),
	},
	c = {
		parse({trig="#include", wordTrig=true}, hash_include),
		parse({trig="pp", wordTrig=true}, prints.c),
	},
	html = {
		parse({trig="html", wordTrig=true}, html_bp),
	}
}
