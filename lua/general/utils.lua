Util = {}

--> Centering an array of strings
function Util.center(dict)
    local new_dict = {}
    for _, v in pairs(dict) do
		local padding = vim.fn.max(vim.fn.map(dict, 'strwidth(v:val)'))
		local spacing = (" "):rep(math.floor((vim.o.columns - padding) / 2)) .. v
		table.insert(new_dict, spacing)
	end
    return new_dict
end

--> Noice simple dashboard (prolly temporary)
function Util.noice_board()
	local header = {
		"","", "", "", "", "", "", "",
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
	}
    if vim.api.nvim_buf_get_name(0) == "" then
		vim.api.nvim_buf_set_option(0, 'bufhidden', 'wipe')

		vim.schedule(function()
			vim.fn.matchadd("Error", '[░▒]')
			vim.fn.matchadd("Function", '[▓█▄▀▐▌]')
			local buf = vim.api.nvim_create_buf(false, true)
			local keys = { K='~/.config/kitty/kitty.conf', F='~/.config/fish/config.fish', I='~/.config/nvim/init.lua', A='~/.config/alacritty/alacritty.yml', P='~/.config/picom/picom.conf' }
			local opts = {noremap = true, silent = true}

			vim.api.nvim_win_set_buf(0, buf)
			vim.api.nvim_put(Util.center(header), "l", true, true)
			vim.cmd [[silent! setlocal nonu nornu autochdir ft=dashboard]]

			for k,f in pairs(keys) do
				vim.api.nvim_buf_set_keymap(0,'n',k,':e '..f..' | setlocal noautochdir<CR>',opts)
			end
			vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<cmd>q<CR>', opts)
		end)
    end
end

--> Closing Windows and buffers
Util.close_command = function()
	local total = 0
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_is_valid(buf) then
			total = total + 1
		end
	end

	vim.cmd(total == 1 and ":q" or ":bd")
end


--> Different Kinds of Borders
local borders = {
	{ "╒", "═", "╕", "│", "╛", "═", "╘", "│" },
	{ "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" },
	{ "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
}
Util.border = borders[1]

--> Custom telescope theme
Util.telescope_theme = {
	results_title = false,
	layout_strategy = "center",
	previewer = false,
	winblend = 30,
	layout_config = { width = 0.6, height = 0.6 },
	borderchars = {
		preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		results = { "─", " ", " ", " ", "╰", "╯", " ", " " },
	},
}

return Util
