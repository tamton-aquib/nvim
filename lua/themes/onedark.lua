
local cmd = vim.api.nvim_command

-- vim.g.onedark_hide_endofbuffer = 1
-- vim.g.onedark_terminal_italics = 1
-- vim.g.onedark_termcolors = 256

-- cmd  [[autocmd ColorScheme * call onedark#extend_highlight("Normal", { "bg": { "gui": "none" } })]]

-- vim.g.onedark_transparent = true
-- vim.g.onedark_dark_float = true
cmd [[ syntax on ]]
cmd [[ colo onedark ]]

