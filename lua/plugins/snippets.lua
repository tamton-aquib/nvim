local ls = require'luasnip'
local parse = ls.parser.parse_snippet

local prints = {
	rust = [[println!("{${0}}");]],
	python = [[print(${0})]],
	javascript = [[console.log(${0});]],
	lua = [[print(${0})]],
	c = [[printf("${0}");]],
	cpp = [[std::cout << ${0} << std::endl;]]
}

ls.snippets = {
	all = {
		parse({trig="#!", wordTrig=true}, "#!/usr/bin/env ${0}"),
	},
	python = {
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
		parse({trig="pp", wordTrig=true}, prints.c),
	},
	cpp = {
		parse({trig="pp", wordTrig=true}, prints.cpp),
	},
}
