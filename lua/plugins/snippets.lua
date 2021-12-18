local ls = require'luasnip'
local parse = ls.parser.parse_snippet

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

local f_name = vim.fn.expand('%:t:r')
local react_rfc = [[
import React from 'react';

const ]]..f_name..[[ = (${1}) => {
	return (
		${0}
	);
}

export default ]]..f_name

ls.snippets = {
	all = {
		parse({trig="html", wordTrig=true}, html_bp),
		parse({trig="rfc", wordTrig=true}, react_rfc),
		parse({trig="conso", wordTrig=true}, [[console.log(${0})]])
	},
	python = {
		parse({trig="#!", wordTrig=true}, "#!/usr/bin/env python3\n"),
	},
	rust = {
		parse({trig="print", wordTrig=true}, [[println!("${0}");]])
	},
	c = {
		parse({trig="#include", wordTrig=true}, hash_include),
	}
}
