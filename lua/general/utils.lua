local Util = {}

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
	local xdg = vim.fn.fnamemodify(vim.fn.stdpath("config"), ":h").."/"
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
			local keys = {
				K = xdg .. 'kitty/kitty.conf',
				F = xdg .. 'fish/config.fish',
				I = xdg .. 'nvim/init.lua',
				A = xdg .. 'alacritty/alacritty.yml',
				P = xdg .. 'picom/picom.conf'
			}
			local opts = {noremap = true, silent = true}

			vim.api.nvim_win_set_buf(0, buf)
			vim.api.nvim_put(Util.center(header), "l", true, true)
			vim.cmd [[silent! setlocal nonu nornu autochdir ft=dashboard]]

			for k,f in pairs(keys) do
				vim.api.nvim_buf_set_keymap(0,'n',k,':e '..f..' | setlocal noautochdir<CR>',opts)
			end
			vim.api.nvim_buf_set_keymap(0, 'n', 'P', '<cmd>Telescope oldfiles<CR>', opts)
			vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<cmd>q<CR>', opts)
		end)
    end
end

--> Closing Windows and buffers
Util.close_command = function()
	local total = 0
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_name(buf) ~= "" then
			total = total + 1
		end
	end

	if vim.bo.modified then print("buf not saved!")  return end
	vim.cmd(total == 1 and ":q!" or ":bd!")
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
	sorting_strategy = "ascending",
	previewer = false,
	prompt_prefix = "      ",
	winblend = 0,
	layout_config = { width = 0.6, height = 0.6 },
	borderchars = {
		preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		prompt = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		results = { "─", " ", " ", " ", "╰", "╯", " ", " " },
	},
}

--> Toggling quickfix window with a keybind
Util.toggle_quickfix = function()
	vim.cmd(not vim.g.quickfix_toggled and "copen" or "cclose")
	vim.g.quickfix_toggled = not vim.g.quickfix_toggled
end

return Util
