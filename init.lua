
--> GENERAL SETTINGS AND MAPPINGS
require 'general.startup'
require 'general.settings'
require 'general.packer'
require 'general.autocommands'
require 'general.mappings'

--> CUSTOMS and THEMES section
require 'custom.noice_board'.setup()
require 'ui.colorschemes'.noice(true)
-- require 'custom.noice_sus'.setup()
vim.cmd [[
if exists('g:started_by_firenvim')
  set laststatus=0
  set showtabline=0
else
  set laststatus=2
  set showtabline=2
endif
]]

require'staline'.setup {

	sections = {
		left = {
			' ', 'right_sep_double', '-mode', 'left_sep_double', ' ',
			'right_sep', '-file_name', 'left_sep', ' ',
			'right_sep_double', '-branch', 'left_sep_double', ' ',
		},
		mid  = {'lsp'},
		right= {
			'right_sep', '-cool_symbol', 'left_sep', ' ',
			'right_sep', '- ', '-lsp_name', '- ', 'left_sep',
			'right_sep_double', '-line_column', 'left_sep_double', ' ',
		}
	},

	defaults={
		fg = "#986fec",
		cool_symbol = "  ",
		left_separator = "",
		right_separator = "",
		-- line_column = "%l:%c [%L]",
		true_colors = true,
		line_column = "[%l:%c] 並%p%% "
		-- font_active = "bold"
	},
	mode_colors = {
		n  = "#181a23",
		i  = "#181a23",
		ic = "#181a23",
		c  = "#181a23",
		v  = "#181a23"       -- etc
	}
}
