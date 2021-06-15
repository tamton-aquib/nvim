
vim.g.startify_lists = {
    { type = 'files',      header = {'   Files'} },
    { type = 'bookmarks',  header = {'   Bookmarks'} }, 
    { type = 'dir',        header = {'   Files ' .. vim.fn.getcwd()} }, 
    { type = 'sessions',   header = {'   Sessions'} }, 
}

vim.g.startify_bookmarks = {
            { Q = '~/.config/qtile/config.py' },
            { I = '~/.config/nvim/init.lua' },
            { F = '~/.config/fish/config.fish' },
            { K = '~/.config/kitty/kitty.conf' },
            { A = '~/.config/alacritty/alacritty.yml' },
}

vim.g.startify_change_to_vcs_root = 1
vim.g.startify_fortune_use_unicode = 1
vim.g.startify_enable_special = 0

vim.g.startify_custom_header = { 
	[[       ▄▄▄█████▓    ▄▄▄          ▄▄▄██▀▀▀]],
	[[       ▓  ██▒ ▓▒   ▒████▄          ▒██   ]],
	[[       ▒ ▓██░ ▒░   ▒██  ▀█▄        ░██ ]],
	[[       ░ ▓██▓ ░    ░██▄▄▄▄██    ▓██▄██▓  ]],
	[[         ▒██▒ ░     ▓█   ▓██▒    ▓███▒  ]],
	[[         ▒ ░░       ▒▒   ▓▒█░    ▒▓▒▒░ ]],
	[[           ░         ▒   ▒▒ ░    ▒ ░▒░]],
	[[         ░           ░   ▒       ░ ░ ░  ]],
	[[                         ░  ░    ░   ░  ]],
}
