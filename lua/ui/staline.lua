--> staline setup
-- #181a23    
--            
-- local leftSeparator = ""	-->      
-- local rightSeparator = ""	-->      
-- TODO: cleanup the whole file
local Styles = {}

require('stabline').setup {
	style = "slant",
	stab_start = "   ",
	stab_bg = "#1e1e1e",
	font_active = "bold,italic",
	bg = "#11121d",
	-- bg = "#0e171c",
	fg = "#8dbd67"
}

vim.cmd [[hi Rocket guifg=#f36365 guibg=none gui=bold]] -- #97c374

vim.g.staline_date = true
vim.api.nvim_set_keymap('n', '<leader>k', ':lua vim.g.staline_date=not vim.g.staline_date<CR>', {noremap=true, silent=true})
Styles.nice_line = {
	sections = {
		left = {''},
		right = {},
		mid = {
			'right_sep_double',
			"-   ",
			function()
				local yes = not vim.g.staline_date and os.date("%Y") or os.date("%I:%M %P ")
				return "%#StalineFill# "..yes
			end,
			'left_sep_double'
		}
	},
	defaults = {
		left_separator = "",
		right_separator = ""
	},
	mode_colors = {
		n  = "#97c374",
		i  = "#97c374",
		ic = "#97c374",
		c  = "#97c374",
		v  = "#97c374",       -- etc
		V  = "#97c374"       -- etc
	}
}

Styles.simple_line = {
	sections = {
		left = {
			'  ', 'mode', ' ', 'branch',
			function()
				if vim.o.columns > 100 then
					return '     '
				end
				return ''
			end
		},
		mid = { 'lsp', '%<'},
		right = {'%l/%L  :%c  ', 'file_name', '  ',
			function()
				local current_line = vim.fn.line "."
				local total_lines = vim.fn.line "$"
				local chars = { "_", "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
				local line_ratio = current_line / total_lines
				local index = math.ceil(line_ratio * #chars)
				return chars[index]
			end, ' '
		},
		defaults = {
			bg = "#0e171c"
		}
	},
	-- mode_colors = {
		-- i = "#986fec",
		-- -- n = "#759a51",
		-- n = "#7aa2f7"
	-- },

	mode_colors = {
		n = "#986fec",
		i = "#e86671",
		ic= "#e86671",
		c = "#e27d60"
	},
	-- mode_colors = {
		-- -- n = "#38b1f0",
		-- -- i = "#9ece6a",       -- etc mode
		-- n = "#97c374",
		-- -- n = "#61afef",
		-- i = "#97c374",       -- etc mode
		-- ic= "#97c374",       -- etc mode
		-- c = "#c94f6d",
	-- },
	defaults = {
		true_colors = true,
		line_column = " [%l/%L] :%c  ",
		branch_symbol = " ",
	}
}

Styles.evil_line = {
	sections = {
		left = {
			'▊', '  ',
			{ 'Evil', '  ' },
			' ',       -- The mode and evil sign
			'file_size', ' ',                         -- Filesize
			{ 'StalineFile', 'file_name' },
			' ', 'lsp'
		},
		mid = { 'lsp_name' },                         -- "lsp_name" is still a little buggy
		right = {
			{ 'StalineGit', ' %l/%L :%c  '},
			{ 'StalineEnc', vim.bo.fileencoding:upper() }, '  ',  -- Example for custom section
			{ 'StalineEnc', 'cool_symbol' }, ' ',                 -- the cool_symbol for your OS
			{ 'StalineGit', 'branch' }, ' ',
			function()
				local current_line = vim.fn.line "."
				local total_lines = vim.fn.line "$"
				local chars = { "_", "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
				local line_ratio = current_line / total_lines
				local index = math.ceil(line_ratio * #chars)
				return chars[index]
			end
		}
	},
	defaults = {
		-- bg = "#202020",
		bg = "#202328",
		branch_symbol = " ",
		true_colors = true,
		font_active = "bold"
	},
	mode_colors = {
		-- n = "#38b1f0",
		-- i = "#9ece6a",       -- etc mode
		n = "#61afef",
		i = "#97c374",       -- etc mode
		ic= "#97c374",       -- etc mode
		c = "#c94f6d",
	}
}

vim.cmd [[hi Evil        guifg=#f36365 guibg=#202328]]             -- Higlight for Evil symbol
vim.cmd [[hi StalineEnc  guifg=#7d9955 guibg=#202328]]       -- Encoding Highlight
vim.cmd [[hi StalineGit  guifg=#8583b3 guibg=#202328]]       -- Branch Name Highlight
vim.cmd [[hi StalineFile guifg=#c37cda guibg=#202328]]      -- File name Highlight

Styles.atom_line = {
	sections = {
		left = {' ', '', '-   ', {'FileNameHighlight', 'file_name'}, {'FileNameRightSepHighlight',''}, 'branch' },
		mid = {'-lsp'},
		right = {
			'', '-mode', {'FileNameHighlight', 'line_column'},
			{'FileNameHighlight'," ".. os.date("%I:%M").." "},
			{'FileNameRightSepHighlight',''}, '  '
		},
	},
	defaults = {
		font_active = "bold,italic",
		branch_symbol = " ",
		true_colors = true,
		line_column = " %l/%L :%c "
	},
	mode_icons = {
		n = "NORMAL",
		i = "INSERT",
		c = "COMMAND"
	},
	mode_colors = {
		-- n = "#e95678",
		n = "#986fec",
		i = "#9ece6a",
		ic= "#9ece6a"
	}
}

vim.cmd [[hi FileNameHighlight guifg=white guibg=#393b4d]]
vim.cmd [[hi FileNameRightSepHighlight guifg=#393b4d]]
-- ;#a3be8c

Styles.normal_line = {
	sections = {
		left = {
			{ 'StalineFill', ' ' },
			{ 'StalineFill', 'mode' },
			'left_sep_double', ' ', 'branch', 'cool_symbol'
		},
		mid = {
			'file_name',
			'lsp'
		},
		right = {
			function() return vim.bo.fileencoding or "" end,
			'  ',
			'right_sep_double',
			{ 'StalineFill', 'line_column' }
		}
	},
	defaults = {
		cool_symbol = "  ",
		left_separator = "",
		right_separator = "",
		bg = "#202328",
		full_path = false,
		branch_symbol = " "
	},
	mode_colors = {
		n = "#986fec",
		i = "#e86671",
		ic= "#e86671",
		c = "#e27d60"
		-- n = "#dddddd",
		-- i = "#dddddd",
		-- ic= "#dddddd",
		-- c = "#dddddd"
	}
}

Styles.pebble_line = {
	sections = {
		left = {
			' ', 'right_sep_double', '-mode', 'left_sep_double', ' ',
			'right_sep', '-file_name', 'left_sep', ' ',
			-- 'right_sep_double',
			-- '-branch',
			function()
				local head = vim.g.gitsigns_head or ""
				return (head ~= nil or head ~= "") and unpack({"   "..head}) or ""
			end,
			-- 'left_sep_double', ' ',
		},
		mid = { 'lsp' },
		right= {
			'right_sep', '-cool_symbol', 'left_sep', '%< ',
			'right_sep', '- ', '-lsp_name', '- ', 'left_sep', ' ',
			-- 'right_sep_double', '-line_column', 'left_sep_double', ' ',
			'right_sep_double', '-line_column', 'left_sep_double', ' ',
		}
	},

	defaults={
		-- fg = "#97c374",
		-- fg = "#986fec",
		cool_symbol = "  ",
		left_separator = "",
		right_separator = "",
		-- line_column = "%l:%c [%L]",
		true_colors = true,
		line_column = "[%l:%c] 並%p%% "
		-- font_active = "bold"
	},
	-- mode_colors = {
		-- n  = "#0e171c",
		-- i  = "#0e171c",
		-- ic = "#0e171c",
		-- c  = "#0e171c",
		-- v  = "#0e171c",       -- etc
		-- V  = "#0e171c",       -- etc
		-- [""] = "#0e171c"
	-- }
	-- #97c374
	mode_colors = {
		n  = "#97c374",
		i  = "#97c374",
		ic = "#97c374",
		c  = "#97c374",
		v  = "#97c374",
		V  = "#97c374"
	}
}
-- Styles.bruh_line = {
	-- sections = {
		-- left = {
			-- function()
				-- return ("▁"):rep(vim.fn.winwidth(0))
			-- end
		-- }, -- change thickness: "_", "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█"
		-- mid = {},
		-- right = {}
	-- },
-- }

require("staline").setup(Styles.nice_line)
-- vim: foldlevelstart=10:fdm=indent
