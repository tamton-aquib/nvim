Mod = {}
local vim = vim
local cmd = vim.api.nvim_command

T = {}

local c = {
	black			 = "#000000",

	violet_one       = "#c678dd",
	violet_two		 = "#986fec",
    violet_three	 = "#c882e7",

	green_one        = "#5af78e",
	green_two        = "#98c379",
    green_three      = "#7eca9c",

	blue_one         = "#56b6c2",
	blue_two		 = "#61afef",
	blue_three       = "#8485ce",

	yellow_one       = "#ebcb8b",
	yellow_two		 = "#fff94c",
	yellow_three	 = "#ffcc00",
	yellow_four		 = "#ffa500",

    orange_one		 = "#fca2aa",
	orange_two       = "#e27d60",

	red_one          = "#e86671",
	red_two          = "#f7768e",


	white_one        = "#ffffff",
	white_two        = "#dddddd",
	white_five		 = "#999999",
	white_three      = "#5c6370",
	white_four		 = "#555555",
	background       = "#282c34",
	background_dark  = "#1f1f1f",
}

T.UsualHighlights = {
	Normal			= { fg = c.white_two, bg = c.background },
	LineNr			= { fg = c.white_three, bg = 'none' },
	CursorLineNr	= { fg = c.white_one},
	SignColumn		= { bg = c.background},
	EndOfbuffer		= { fg = c.background},
	NormalFloat 	= { fg = c.green_one, bg=c.background_dark},
	NonText			= { fg = c.white_three },
	CursorLine		= { bg = c.background_dark},
	Question		= { fg = c.green_three},

	Folded			= { fg = c.black, bg = c.white_five},
	Matchparen		= { gui='underline'},
	MsgArea			= { fg = c.white_one},
	Pmenu			= { fg = c.white_two, bg = c.background_dark},
	Pmenusel		= { fg = c.black, bg = c.violet_two },
	-- PmenuSbar		= { bg = c.red_one, fg = c.violet_one}
	-- PmenuThumb		= { fg = c.background},
	Visual			= { gui='reverse'},
	-- usualhighlights like String, Function, Constant,
	-- mkd markdown stuff
	StatusLine		= { bg = c.background_dark },
	TablineFill		= { bg = c.background_dark },
	TablineSel		= { bg = c.background, gui = 'bold' }
}

T.Programming = {
	htmlTagName			= { fg=c.red_one},
	htmlTag				= { fg=c.violet_one},
	htmlArg				= { fg = c.green_one},
	cssTagName			= { fg = c.red_one},
	cssDefinition		= { fg = c.white_one},
}

T.LspRelated = {
	LspDiagnosticsSignError = { fg = c.red_one, gui = 'bold' },
	LspDiagnosticsSignWarning = { fg = c.yellow_three, gui='bold' },
	LspDiagnosticsSignHint = { fg = c.blue_one, gui = 'bold' },
	LspDiagnosticsSignInformation = { fg = c.red_one, gui = 'italic' },

	LspDiagnosticsUnderlineError = { sp = c.red_one, gui = 'undercurl'},
	LspDiagnosticsUnderlineWarning = { sp = c.yellow_three, gui = 'undercurl'},
	LspDiagnosticsUnderlineHint = { sp = c.blue_one, gui = 'undercurl'},
	LspDiagnosticsUnderlineInformation = { sp = c.red_one, gui = 'undercurl'},
}

T.Telescope = {
	Telescopeborder = { fg = c.red_two}
}

T.TSHighlights = {
	TSKeyword			= { fg = c.red_one },
	TSKeywordFunction	= { fg = c.violet_one },
	TSString			= { fg = c.green_two },
	TSInclude			= { fg = c.violet_one},
	TSComment			= { fg = c.white_three, gui = 'italic'},
	TSFuncBuiltin		= { fg = c.violet_one},
	TSOperator			= { fg = c.red_two },
	TSPunctDelimiter	= { fg = c.white_one},
	TSMethod			= { fg = c.blue_two},
	TSFunction			= { fg = c.violet_one },
	TSVariable			= { fg = c.white_two },
	TSType				= {},
	TSRepeat			= { fg = c.red_two},
	TSConstructor		= { fg = c.blue_one },
	TSProperty			= { fg = c.blue_two},

	TSField				= { fg = c.red_two},
	TSPunctBracket		= { fg = c.blue_two},
	-- TSPunctDelimiter
	TSParameter			= { fg = c.orange_two},
	TSConditional		= { fg = c.red_two}
}

local function init_clear()
	cmd 'highlight clear'

	if vim.fn.exists("syntax_on") then
		cmd 'syntax reset'
	end

	vim.g.colors_name = "taj_scheme"
end

function Mod.LDS()
	local signs = {
        Error = "",
        Warning = " ",
        Hint = "",
        Information = "",
        other = "﫠"
	}
	for type, icon in pairs(signs) do
	  local hl = "LspDiagnosticsSign" .. type
	  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end
end

function Mod.set()
	init_clear()

	for _, HighlightGroup in pairs(T) do
		for highlight, value in pairs(HighlightGroup) do
			local fore = value.fg or "none"
			local back = value.bg or "none"
			local gui  = value.gui or "none"
			local sp   = value.sp or "none"
			cmd('hi '..highlight..
				' guifg='..fore..
				' guibg='..back..
				' gui='..gui..
				' guisp='..sp
			)
		end
	end
	Mod.LDS()
end

return Mod
