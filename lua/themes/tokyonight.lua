
local cmd = vim.api.nvim_command

-- vim.g.tokyonight_style = 'night'
-- vim.g.tokyonight_enable_italic = 1
-- vim.g.tokyonight_transparent_background = 1

-- vim.g.tokyonight_transparent_background = true
vim.g.tokyonight_italic_keywords = false
vim.g.tokyonight_italic_functions = false
vim.g.tokyonight_style = "night"

cmd('syntax on')
cmd('colorscheme tokyonight')
cmd('hi SignColumn guibg=none')
