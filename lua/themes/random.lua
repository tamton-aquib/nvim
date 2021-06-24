
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
	if selected == nil then selected = "onedark" end
	print("ColorScheme: "..selected)
	vim.cmd('colo '..selected)
end

vim.api.nvim_set_keymap('n', '<leader>c', ':lua Return_Scheme()<CR>', {noremap=true})

