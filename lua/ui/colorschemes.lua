local Colo = {}

-- TODO: NOICE COLOR PALETTE (might port in future)
-- "#c678dd", "#986fec", "#c882e7",
-- "#5af78e", "#98c379", "#7eca9c",
-- "#56b6c2", "#61afef", "#8485ce",
-- "#ebcb8b", "#fff94c", "#ffcc00",
-- "#fca2aa", "#e27d60",
-- "#e86671", "#f7768e",
-- "#ffffff", "#dddddd", "#999999", "#5c6370",
-- "#282c34", "#24283b", "#11121d", "#1f1f1f",

local colors = {
	-- 'onedark',
	'gruvbox-material',
	'tokyonight',
	'tokyodark',
	'sonokai',
}

function Colo.random()
	math.randomseed(os.clock())
	local nice = math.random() * #colors
	local selected = colors[math.floor(nice)+1]
	print("ColorScheme: "..selected)
	vim.cmd('colo '..selected)
end

function Colo.tokyodark(transparent)
	vim.g.tokyodark_transparent_background = true
	vim.g.tokyodark_enable_italic = true

	vim.cmd [[colo tokyodark]]
	vim.cmd("hi Normal guibg="..(transparent and "none" or "#11121d"))

	vim.cmd [[hi! link IndentBlanklineChar Comment]]
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
	vim.g.gruvbox_material_transparent_background = transparent and 1 or 0
	-- vim.g.gruvbox_flat_style = "dark"
	vim.g.gruvbox_material_cursor = "red"

	vim.cmd [[colo gruvbox-material]]
	vim.cmd [[hi FloatBorder guibg=#45403d]]
end

function Colo.sonokai(transparent)
	vim.g.sonokai_style = 'andromeda'
	vim.g.sonokai_transparent_background = transparent and 1 or 0
    vim.g.gruvbox_material_sign_column_background = 'none'
	vim.g.sonokai_better_performance = 1

	vim.cmd [[colo sonokai]]
end

function Colo.onedark(transparent)
	vim.g.onedark_italic_functions = true
	vim.g.onedark_transparent = transparent and true or false

	require "onedark".setup()
end

return Colo
