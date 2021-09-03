--> staline setup
-- #181a23    
Styles = {}

require 'stabline'.setup {
	style = "bar",
	font_active = "bold,italic",
	stab_start = "%#LspDiagnosticsDefaultError#    ",

	inactive_bg = "#1e1e1e",
	stab_bg = "#1e1e1e",
	fg = "#986fec",
	-- bg = "#1e2127",

	-- stab_end = [[%{luaeval("get_stuff()")}]]
}
-- 
Styles.simple_line = {
	sections = {
		left = { '  ', 'mode', ' ', 'branch', '   ', 'lsp',
			-- function()
				-- local stuff = vim.b.gitsigns_status_dict
				-- local noice = stuff and (stuff.added or "")..
					-- (stuff.removed or "")..
					-- (stuff.changed or "") or ""
				-- return noice
				-- -- return stuff and stuff['head'] or "nice"
			-- end
		},
		mid = {},
		right = {'%l/%L  :%c  ', 'file_name', ' ',
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
	mode_colors = {
		n = "#986fec",
		i = "#759a51",
	},
	defaults = {
		true_colors = true,
		line_column = " [%l/%L] :%c  ",
		branch_symbol = " ",
		font_active = "bold"
	}
}

--    

-- local color_line = {
	-- sections = { left =
		-- { ("▁"):rep(vim.o.columns) },
		-- mid = {},
		-- right = {}
	-- },
-- }


Styles.evil_line = {
	sections = {
		left = {
			'▊', '  ', { 'Evil', '  ' }, ' ',       -- The mode and evil sign
			'file_size', ' ',                         -- Filesize
			{ 'StalineFile', 'file_name' }, ' ',       -- Filename in different highlight
			'lsp'
		},
		mid = { 'lsp_name' },                         -- "lsp_name" is still a little buggy
		right = {

			-- function()
				-- local stuff = vim.b.gitsigns_status_dict
				-- local symbols = { added = "  ", changed = "柳", removed = " " }
				-- local noice = ""
				-- for k, v in pairs(symbols) do
					-- -- noice = noice .. (stuff and symbols[k]..stuff[k] or "").." "
					-- noice = noice .. (stuff and (stuff[k] and symbols[k]..stuff[k] or "") or "")
				-- end
-- 
				-- return noice.."  "
			-- end,
				-- return stuff and stuff['head'] or "nice"
			-- end, '  ',
			{'StalineGit', ' %l/%L :%c  '},
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
		n = "#38b1f0",
		i = "#9ece6a",       -- etc mode
		-- n = "#a89985",
		-- i = "#84a598",
		-- c = "#8fbf7f",
		-- v = "#fc802d",
	}
}

vim.cmd [[hi Evil        guifg=#f36365 guibg=#202328]]             -- Higlight for Evil symbol
vim.cmd [[hi StalineEnc  guifg=#7d9955 guibg=#202328]]       -- Encoding Highlight
vim.cmd [[hi StalineGit  guifg=#8583b3 guibg=#202328]]       -- Branch Name Highlight
vim.cmd [[hi StalineFile guifg=#c37cda guibg=#202328]]      -- File name Highlight

-- require'stabline'.setup {
	-- style = 'bar',
	-- font_active = "bold,italic",
	-- font_inactive = "italic",
	-- -- bg = "#ff6077",
	-- -- fg = "#414550",
	-- fg = "#986fec",
	-- -- stab_bg = "none",
	-- start = "%#BranchGreen#    ",
	-- -- stab_right = ""
	-- -- inactive_bg = "none"
	-- -- bg = "#181a23",
	-- -- bg = "#7741e6",
-- }
-- vim.cmd [[hi BranchGreen guifg=#2bbb4f ]]
--'right_sep', {'LspDiagnosti csSignError', '   '}, 'left_sep',

-- local atom_line = {
	-- sections = {
		-- left = {' ', '', '-   ', {'FileNameHighlight', 'file_name'}, {'FileNameRightSepHighlight',''}, 'branch' },
		-- mid = {'-lsp'},
		-- right = {'', '-mode', {'FileNameHighlight', 'line_column'}, {'FileNameRightSepHighlight',''}, '  ' },
	-- },
	-- defaults = {
		-- font_active = "bold,italic",
		-- branch_symbol = " ",
		-- true_colors = true,
	-- },
	-- mode_icons = {
		-- n = "NORMAL"
	-- },
	-- mode_colors = {
		-- -- n = "#e95678",
		-- n = "#986fec",
		-- i = "#9ece6a",
		-- ic= "#9ece6a"
	-- }
-- }

-- vim.cmd [[hi FileNameHighlight guifg=white guibg=#393b4d]]
-- vim.cmd [[hi FileNameRightSepHighlight guifg=#393b4d]]
-- ;#a3be8c

Styles.normal_line = {
	sections = {
		left = {'- ', '-mode', 'left_sep_double', 'filename', '  ', 'branch'},
		mid  = {'lsp'},
		right= { {'ArchSymbol', 'cool_symbol'}, '  ', vim.bo.fileencoding:upper(), 'right_sep_double', '-line_column'}
	},
	defaults = {
		cool_symbol = "  ",
		left_separator = "",
		right_separator = "",
		bg = "#303030",
		full_path = false,
		branch_symbol = " "
	},
	mode_colors = {
		-- n = "#986fec",
		-- i = "#e86671",
		-- ic= "#e86671",
		-- c = "#e27d60"
		n = "#dddddd",
		i = "#dddddd",
		ic= "#dddddd",
		c = "#dddddd"
	}
}

Styles.pebble_line = {
	sections = {
		left = {
			' ', 'right_sep_double', '-mode', 'left_sep_double', ' ',
			'right_sep', '-file_name', 'left_sep', ' ',
			'right_sep_double', '-branch', 'left_sep_double', ' ',
		},
		mid  = {'lsp'},
		right= {
			'right_sep', '-cool_symbol', 'left_sep', ' ',
			'right_sep', '- ', '-lsp_name', '- ', 'left_sep', ' ',
			'right_sep_double', '-line_column', 'left_sep_double', ' ',}
	},
	defaults={
		-- bg="#181a23",
		-- fg="#986fec",
		fg="#181a23",
		cool_symbol = "  ",
		left_separator = "",
		right_separator = "",
		-- line_column = "%l:%c [%L]",
		true_colors = true,
		line_column = "[%l:%c] 並%p%% "
		-- font_active = "bold"
	},
	mode_colors = {
		n = "#bbbbbb",
		i = "#bbbbbb",
		ic= "#bbbbbb",
		c = "#bbbbbb",
		v = "#bbbbbb"
	}
}

-- 	mode_colors = {
-- 		n = "#986fec",
-- 		i = "#e86671",
-- 		ic= "#e86671",
-- 		c = "#e27d60"
-- 	}
-- local leftSeparator = ""	-->      
-- local rightSeparator = ""	-->      

require "staline".setup(Styles.simple_line)
