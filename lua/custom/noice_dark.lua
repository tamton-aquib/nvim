M = {}
local ns = vim.api.nvim_create_namespace('noice_dark')

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

local back
if vim.g.noice_transparency then
    back = nil
else
    back = c.background
end

local Usual = {
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
	VertSplit	= { fg = c.black, bg = back, bold = true },
	Comment     = { fg = c.white_three, italic = true},

	Identifier	= { fg = c.red_two},
	Statement	= { fg = c.violet_one},
	Type		= { fg = c.green_one},
	Title		= { fg = c.red_two },
	Directory	= { fg = c.blue_one},
	ErrorMsg	= { fg = c.red_one},
	Conceal		= { bg = back},

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
	TSKeyword		= { fg = c.red_two },
	TSKeywordFunction	= { fg = c.red_two },
	TSString		= { fg = c.green_two },
	TSInclude		= { fg = c.violet_one},
	TSComment		= { fg = c.white_three, italic = true},
	TSFuncBuiltin		= { fg = c.blue_two},
	TSTypeBuiltin		= { fg = c.violet_one},
	TSMethod		= { fg = c.blue_two},
	TSVariable		= { fg = c.white_two },
	TSFunction		= { fg = c.violet_one },
	TSVariableBuiltin	= { fg = c.red_two},

	TSType			= { fg = c.red_two},
	TSField			= { fg = c.red_two},

	TSOperator		= { fg = c.red_two },
	TSPunctDelimiter	= { fg = c.white_one},
	TSRepeat		= { fg = c.red_two},
	TSConstructor		= { fg = c.blue_one },
	TSProperty		= { fg = c.blue_two},

	TSPunctBracket		= { fg = c.blue_two},
	-- TSPunctDelimiter
	TSParameter		= { fg = c.orange_two},
	TSConditional		= { fg = c.red_two},
	TSPunctSpecial		= { fg = c.red_one },
	TSNone			= { fg = c.red_one},
	TSTagDelimiter  	= { fg = c.violet_one},
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

local lang = {
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

local Plugins = {
    IndentBlankLine = {
	IndentBlanklineChar = { fg=c.white_three }
    },
    Neorg = {
	    NeorgHeading1 = { fg = "#f7768e"},
	    NeorgHeading2 = { fg = "#ad8ee6"},
	    NeorgHeading3 = { fg = c.green_two},
    },
    Telescope = {
	TelescopeBorder			= { fg = c.blue_two, bg = back},
	TelescopePromptPrefix	= { fg = c.red_two, bg = back},
	TelescopeSelectionCaret = { fg = c.red_two, bg = back},
	TelescopeSelection		= { fg = c.red_two, bg = back}
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
	markdownH1	= { fg = c.red_one, bold = true },
	markdownH2	= { fg = c.red_one, bold = true },
	markdownH3	= { fg = c.red_one, bold = true },
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

local function add_highlight_table(tbl)
    for hl_grp, hl_value in pairs(tbl) do
	vim.api.nvim_set_hl(ns, hl_grp, hl_value)
    end
end

function M.Lang_high(ft)
    if vim.api.nvim_buf_is_valid(0) and vim.api.nvim_buf_is_loaded(0) then
	add_highlight_table(lang[ft] or {})
    end
end

function M.noice()
    vim.cmd 'highlight clear'
    if vim.fn.exists("syntax_on") then vim.cmd'syntax reset' end
    vim.g.colors_name = "noice"

    for _, tbl in pairs(Usual) do add_highlight_table(tbl) end
    for _, tbl in pairs(Plugins) do add_highlight_table(tbl) end

    local bg = back or "none"
    vim.cmd('hi Normal guibg='..bg..' guifg=#dddddd')

    vim.cmd [[au BufEnter,FileType * :lua require"custom.noice_dark".Lang_high(vim.bo.ft)]]
    vim.api.nvim__set_hl_ns(ns)
end

return M