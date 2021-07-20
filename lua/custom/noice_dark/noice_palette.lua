T = {Usual = {}, lang = {}, Plugins = {}}
T.back = ""

local c = {
	black            = "#000000",

	violet_one       = "#c678dd",
	violet_two       = "#986fec",
    violet_three     = "#c882e7",

	green_one        = "#5af78e",
	green_two        = "#98c379",
    green_three      = "#7eca9c",

	blue_one         = "#56b6c2",
	blue_two         = "#61afef",
	blue_three       = "#8485ce",

	yellow_one       = "#ebcb8b",
	yellow_two       = "#fff94c",
	yellow_three     = "#ffcc00",

    orange_one       = "#fca2aa",
	orange_two       = "#e27d60",

	red_one          = "#e86671",
	red_two          = "#f7768e",


	white_one        = "#ffffff",
	white_two        = "#dddddd",
	white_five       = "#999999",
	white_three      = "#5c6370",
	white_four       = "#555555",
	background       = "#282c34",
	background_dark  = "#1f1f1f",
}

-- local back
if vim.g.noice_transparency then
	T.back = nil
else
	T.back = c.background
end

T.Usual = {
	UsualHighlights = {
		-- Normal		= { fg = c.white_two, bg = back },
		NormalFloat = { fg = c.white_two, bg = c.background_dark},
		FloatBorder = { fg = c.blue_one, bg = c.background_dark },
		LineNr		= { fg = c.white_three, bg = nil },
		SignColumn	= { bg = nil},
		EndOfbuffer	= { fg = c.background},
		NonText		= { fg = c.white_three },
		CursorLine	= { bg = c.background_dark},
		CursorLineNr= { fg = c.white_one},
		Cursor		= { reverse = true },
		Question	= { fg = c.green_three},
		VertSplit	= { fg = c.black, bg = T.back, bold = true },
		Comment     = { fg = c.white_three, italic = true},

		Identifier	= { fg = c.red_one},
		Statement	= { fg = c.violet_one},
		Type		= { fg = c.green_one},
		Title		= { fg = c.red_one },
		Directory	= { fg = c.blue_one},
		ErrorMsg	= { fg = c.red_one},
		Conceal		= { bg = T.back},

		Folded		= { fg = c.black, bg = c.white_five},
		Matchparen	= { underline = true},
		MsgArea		= { fg = c.white_one},
		Pmenu		= { fg = c.white_two, bg = c.background_dark},
		Pmenusel	= { fg = c.black, bg = c.violet_two },
		-- PmenuSbar		= { bg = c.red_one, fg = c.violet_one}
		-- PmenuThumb		= { fg = c.background},
		Visual		= { reverse = true },
		StatusLine	= { bg = c.background_dark },
		TablineFill	= { bg = c.background_dark },
		TablineSel	= { bg = c.background, bold = true },
	},

	TSHighlights = {
		TSKeyword			= { fg = c.red_one },
		TSKeywordFunction	= { fg = c.violet_one },
		TSString			= { fg = c.green_two },
		TSInclude			= { fg = c.violet_one},
		TSComment			= { fg = c.white_three, italic = true},
		TSFuncBuiltin		= { fg = c.violet_one},
		TSMethod			= { fg = c.blue_two},
		TSVariable			= { fg = c.white_two },
		TSFunction			= { fg = c.violet_one },
		TSVariableBuiltin	= { fg = c.green_one},

		TSType				= { fg = c.red_one},
		TSField				= { fg = c.red_two},

		TSOperator			= { fg = c.red_two },
		TSPunctDelimiter	= { fg = c.white_one},
		TSRepeat			= { fg = c.red_two},
		TSConstructor		= { fg = c.blue_one },
		TSProperty			= { fg = c.blue_two},

		TSPunctBracket		= { fg = c.blue_two},
		-- TSPunctDelimiter
		TSParameter			= { fg = c.orange_two},
		TSConditional		= { fg = c.red_two},
		TSPunctSpecial		= { fg = c.red_one },
		TSNone				= { fg = c.red_one},
		TSTagDelimiter      = { fg = c.violet_one},
		TSTagAttribute		= { fg = c.red_two},
	},

	LspRelated = {
		LspDiagnosticsSignError = { fg = c.red_one, bg = nil,bold = true },
		LspDiagnosticsSignWarning = { fg = c.yellow_three, bg = nil, bold = true },
		LspDiagnosticsSignHint = { fg = c.blue_one, bg = nil, bold = true },
		LspDiagnosticsSignInformation = { fg = c.green_three, bg=nil, italic = true },

		LspDiagnosticsUnderlineError = { sp = c.red_one, undercurl = true},
		LspDiagnosticsUnderlineWarning = { sp = c.yellow_three, undercurl = true},
		LspDiagnosticsUnderlineHint = { sp = c.blue_one, undercurl = true},
		LspDiagnosticsUnderlineInformation = { sp = c.red_one, undercurl = true},
	},
}

T.lang = {
	html = {
		htmlTagName			= { fg = c.red_one},
		htmlTag				= { fg = c.violet_one},
		htmlArg				= { fg = c.blue_one},
		cssTagName			= { fg = c.red_one},
		cssDefinition		= { fg = c.white_one},
	}
}

T.Plugins = {
	Telescope = {
		TelescopeBorder			= { fg = c.blue_two, bg = T.back},
		TelescopePromptPrefix	= { fg = c.red_two, bg = T.back},
		TelescopeSelectionCaret = { fg = c.red_two, bg = T.back},
		TelescopeSelection		= { fg = c.red_two, bg = T.back}
	},
	NvimTree = {
		NvimTreeRootFolder = { fg = c.red_two, bold = true},
		NvimTreeFolderIcon = { fg=c.blue_one },
		NvimTreeSpecialFile = { fg=c.green_three }
	},
	GitSign = {
		GitSignsAdd = { fg = c.green_one },
		GitSignsChange = { fg = c.yellow_one},
		GitSignsDelete = { fg = c.red_one}
	},

	MarkdownHighlights = {
		markdownH1				= { fg = c.red_one, bold = true },
		markdownH2				= { fg = c.red_one, bold = true },
		markdownH3				= { fg = c.red_one, bold = true },
		markdownHeadingDelimiter= { fg = c.white_three},
		markdownItalic			= { italic = true },
		markdownBold			= { bold = true },
		markdownItalicDelimiter = { fg = c.white_three , italic = true },
		markdownBoldDelimiter	= { fg = c.white_three , italic = true },
		markdownBlockquote		= { fg = c.violet_two, bold = true },
		markdownCode			= { fg = c.green_two },
		markdownCodeDelimiter	= { fg = c.green_two, italic = true},
		markdownListMarker		= { fg = c.orange_two }
	}
}

return T
