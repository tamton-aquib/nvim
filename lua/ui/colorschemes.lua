Colo = {}

local colors = {
	'onedark',
	'gruvbox-flat',
	'tokyonight',
	'tokyodark',
	'sonokai',
	'noice',
	'catppuccino'
}

function Colo.random()
	math.randomseed(os.clock())
	local nice = math.random() * #colors
	local selected = colors[math.floor(nice)+1]
	print("ColorScheme: "..selected)
	vim.cmd('colo '..selected)
end

function Colo.catppuccino(transparent)
	local cap = require "catppuccino"
	cap.setup{
		-- colorscheme = "neon_latte",
		colorscheme = "dark_catppuccino",
		transparency = transparent,
	}
	cap.load()
	vim.cmd [[hi FloatBorder guibg=#0b1115]]
	vim.cmd [[hi IndentBlanklineSpaceChar guifg=none]]
end

function Colo.tokyodark(transparent)
	vim.g.tokyodark_transparent_background = true
	vim.g.tokyodark_enable_italic = false

	vim.cmd [[colo tokyodark]]
	vim.cmd("hi Normal guibg="..(transparent and "none" or "#11121d"))
	vim.cmd [[hi IndentBlanklineChar guifg=#555555]]
end

function Colo.tokyonight(transparent)
	vim.g.tokyonight_style = "night"
	vim.g.tokyonight_italic_keywords = true
	vim.g.tokyonight_italic_functions = true
	-- vim.g.tokyonight_style = "night"
	-- vim.g.tokyonight_transparent_background = transparent and 1 or 0
	vim.g.tokyonight_transparent = transparent and 1 or 0

	vim.cmd [[colo tokyonight]]
	vim.cmd [[hi NormalFloat guibg=#1a1b26]]
	-- vim.cmd [[hi FloatBorder guibg=#2a2b3d]]
	-- vim.cmd [[hi SignColumn guibg=#1a1b26]]
end

function Colo.gruvbox(transparent)
	vim.g.gruvbox_transparent = transparent and true or false
	vim.g.gruvbox_flat_style = "dark"

	vim.cmd [[colo gruvbox-flat]]
end

function Colo.sonokai(transparent)
	vim.g.sonokai_style = 'andromeda'
	vim.g.sonokai_transparent_background = transparent and 1 or 0
	vim.g.sonokai_better_performance = 1

	vim.cmd [[colo sonokai]]
end

function Colo.onedark(transparent)
	vim.g.onedark_italic_functions = true
	vim.g.onedark_transparent = transparent and true or false

	require "onedark".setup()
end

function Colo.noice(transparent)
	vim.g.noice_transparency = transparent and true or false

	vim.cmd [[colo noice]]
end

return Colo
