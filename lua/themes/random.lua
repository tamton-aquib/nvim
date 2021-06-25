
local colors = {
	'onedark',
	'gruvbox-flat',
	'tokyonight',
	'sonokai'
}

function Return_Scheme()
	math.randomseed(os.clock())
	local nice = math.random() * #colors
	local selected = colors[math.floor(nice)+1]
	print("ColorScheme: "..selected)
	-- vim.g.colors_name = selected
	vim.cmd('colo '..selected)
end

vim.api.nvim_set_keymap('n', '<leader>c', ':lua Return_Scheme()<CR>', {noremap=true})

