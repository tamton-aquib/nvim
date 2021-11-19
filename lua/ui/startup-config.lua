local mod = vim.fn.fnamemodify
local set_stuff = function()
	local keymaps = {
		I = "~/.config/nice/init.lua",
		K = "~/.config/kitty/kitty.conf",
		A = "~/.config/alacritty/alacritty.yml"
	}
	for key, file in pairs(keymaps) do
		local buf
		if vim.bo.ft == "startup" then
			buf = vim.api.nvim_get_current_buf()
			vim.api.nvim_buf_set_keymap(buf, 'n', key,
			':e '..file..' | lua vim.api.nvim_set_current_dir("'..mod(file, ":h")..'")<CR>',
				{noremap=true, silent=true}
			)
		end
	end
end

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

	-- command = "call matchadd('Error', '[░▒]')",
	command = "",
	fold_section = false,
	oldfiles_directory = false,
	oldfiles_amount = 10
}

require("startup").setup{
	section_1 = section1,
	options = {
		disable_statuslines = false,
		after = function()
			vim.fn.matchadd("Error", '[░▒]')
			set_stuff()
		end
	},

	parts = { "section_1" }
}

