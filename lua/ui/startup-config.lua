
local section1 = {
	type = "text",
	align = "center",
	title = "Noice",
	content = {
		[[]], [[]], [[]], [[]], [[]], [[]], [[]], [[]], [[]], [[]],
		[[ ███▄    █     ▒█████      ██▓    ▄████▄     ▓█████   ]],
		[[ ██ ▀█   █    ▒██▒  ██▒   ▓██▒   ▒██▀ ▀█     ▓█   ▀   ]],
		[[▓██  ▀█ ██▒   ▒██░  ██▒   ▒██▒   ▒▓█    ▄    ▒███     ]],
		[[▓██▒  ▐▌██▒   ▒██   ██░   ░██░   ▒▓▓▄ ▄██▒   ▒▓█  ▄   ]],
		[[▒██░   ▓██░   ░ ████▓▒░   ░██░   ▒ ▓███▀ ░   ░▒████▒  ]],
		[[░ ▒░   ▒ ▒    ░ ▒░▒░▒░    ░▓     ░ ░▒ ▒  ░   ░░ ▒░ ░  ]],
		[[░ ░░   ░ ▒░     ░ ▒ ▒░     ▒ ░     ░  ▒       ░ ░  ░  ]],
		[[   ░   ░ ░    ░ ░ ░ ▒      ▒ ░   ░              ░     ]],
		[[         ░        ░ ░      ░     ░ ░            ░  ░  ]],
		[[                                 ░                    ]]
	},
	highlight = "Function",
	margin = 0,
	default_color = "#333333",

	command = "call matchadd('Error', '[░▒]')",
	fold_section = false,
	oldfiles_directory = false,
	oldfiles_amount = 10
}

require("startup").setup{
	section_1 = section1,
	options = {
		disable_statuslines = true
	},

	parts = { "section_1" }
}

