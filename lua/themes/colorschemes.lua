Colo = {}

local colors = {
	'onedark',
	'gruvbox-flat',
	'tokyonight',
	'sonokai'
}

function Colo.return_Scheme()
	math.randomseed(os.clock())
	local nice = math.random() * #colors
	local selected = colors[math.floor(nice)+1]
	print("ColorScheme: "..selected)
	-- vim.g.colors_name = selected
	vim.cmd('colo '..selected)
end

function Colo.tokyonight(transparent)
	vim.g.tokyonight_italic_keywords = false
	vim.g.tokyonight_italic_functions = false
	vim.g.tokyonight_style = "night"
	vim.g.tokyonight_transparent_background = transparent and 1 or 0

	vim.cmd [[colo tokyonight]]
end

function Colo.sonokai(transparent)
	vim.g.monokai_style = 'andromeda'
	vim.g.sonokai_transparent_background = transparent and 1 or 0
	vim.g.sonokai_better_performance = 1
	vim.cmd [[colo sonokai]]
end

function Colo.onedark(transparent)
	vim.g.onedark_italic_functions = true
	vim.g.onedark_transparent = transparent and true or false
	vim.cmd [[colo onedark]]
end

function Colo.bruh(transparent)
	vim.g.noice_transparency = transparent and true or false
	vim.cmd [[colo bruh]]
end

return Colo
