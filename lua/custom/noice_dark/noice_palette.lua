T = {Usual = {}, lang = {}, Plugins = {}}
T.back = ""
-- nice

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
		FloatBorder = { fg = c.blue_one, bg = c.background_dark},
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

		Identifier	= { fg = c.red_two},
		Statement	= { fg = c.violet_one},
		Type		= { fg = c.green_one},
		Title		= { fg = c.red_two },
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
		TSKeyword			= { fg = c.red_two },
		TSKeywordFunction	= { fg = c.red_two },
		TSString			= { fg = c.green_two },
		TSInclude			= { fg = c.violet_one},
		TSComment			= { fg = c.white_three, italic = true},
		TSFuncBuiltin		= { fg = c.blue_two},
		TSTypeBuiltin		= { fg = c.violet_one},
		TSMethod			= { fg = c.blue_two},
		TSVariable			= { fg = c.white_two },
		TSFunction			= { fg = c.violet_one },
		TSVariableBuiltin	= { fg = c.red_two},

		TSType				= { fg = c.red_two},
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
		LspDiagnosticsSignError = { fg = c.red_one, bold = true },
		LspDiagnosticsSignWarning = { fg = c.yellow_three, bold = true },
		LspDiagnosticsSignHint = { fg = c.blue_one, bold = true },
		LspDiagnosticsSignInformation = { fg = c.green_three, italic = true },

		LspDiagnosticsDefaultError = { fg = c.red_one, italic = true, bold=true },
		LspDiagnosticsDefaultWarning = { fg = c.yellow_three, bold = true , italic=true},
		LspDiagnosticsDefaultHint = { fg = c.blue_one, bold = true, italic=true},
		LspDiagnosticsDefaultInformation = { fg = c.green_three, italic = true, bold=true },

		LspDiagnosticsUnderlineError = { sp = c.red_one, undercurl = true},
		LspDiagnosticsUnderlineWarning = { sp = c.yellow_three, undercurl = true},
		LspDiagnosticsUnderlineHint = { sp = c.blue_one, undercurl = true},
		LspDiagnosticsUnderlineInformation = { sp = c.red_one, undercurl = true},
	},
}

T.lang = {
	html = {
		TSTag = { fg = c.red_two},
		htmlTSTagAttribute = { fg = c.blue_two},
	},
	css = {
		cssTagName	= { fg = c.red_two},
		Constant = {fg = c.green_three},
		cssBraces = { fg = c.blue_two},
		Type   = { fg = c.blue_three}
	},
	dosini = {
		dosiniLabel = { fg = c.blue_three },
		dosiniNumber = { fg = c.green_two},
		dosiniValue = { fg = c.green_two},
		dosiniHeader = { fg = c.red_two}
	},
	help = {
		helpExample = { fg = c.green_two},
		helpHyperTextJump = { fg = c.blue_three, italic=true},
		helpSpecial = {fg = c.red_two},
		helpHyperTextEntry = {fg = c.blue_one, bold=true}
	}
}

T.Plugins = {
	Neorg = {
		NeorgHeading1 = { fg = "#f7768e"},
		NeorgHeading2 = { fg = "#ad8ee6"},
		NeorgHeading3 = { fg = c.green_two},
	},
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
		GitSignsAdd = { fg = c.green_three },
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
		markdownListMarker		= { fg = c.orange_two },
		markdownError           = { fg = c.white_two}
	}
}

return T
