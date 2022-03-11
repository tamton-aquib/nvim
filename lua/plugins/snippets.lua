local ls = require'luasnip'
local parse = ls.parser.parse_snippet

local prints = {
	rust = [[println!("{${0}}");]],
	python = [[print(${0})]],
	javascript = [[console.log(${0});]],
	svelte = [[console.log(${0});]],
	lua = [[print(${0})]],
	c = [[printf("${0}");]],
	cpp = [[std::cout << ${0} << std::endl;]]
}

vim.schedule(function()
	ls.snippets = {
		all = {
			parse({trig="#!", wordTrig=true}, "#!/usr/bin/env ${0}"),
			parse({trig="pp", wordTrig=true}, prints[vim.bo.ft] or ""),
		},
	}
end)
