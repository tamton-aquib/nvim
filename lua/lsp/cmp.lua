local cmp = require('cmp')
local luasnip = require "luasnip"

local icons = {
	Class       = "  ",
	Color		= "  ",
	Constant	= "  ",
	Constructor = "  ",
	Enum		= " 了",
	EnumMember  = "  ",
	Field		= "  ",
	File		= "  ",
	Folder		= "  ",
	Function	= "  ",
	Interface	= " ﰮ ",
	Keyword		= "  ",
	Method		= " ƒ ",
	Module		= "  ",
	Property	= "  ",
	Snippet		= "  ",
	Struct		= "  ",
	Text		= "  ",
	Unit		= "  ",
	Value		= "  ",
	Variable	= "  ",
}


cmp.setup {
	formatting ={
		format = function(entry, item)
			item.kind = icons[item.kind] or "noice"
			return item
		end
	},
    documentation = {
      -- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		border = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" },
		winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
    },

    -- snippet = {
      -- expand = function(args)
        -- require("luasnip").lsp_expand(args.body)
      -- end,
    -- },

	mapping = {
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		['<Tab>'] = function(fallback)
			if vim.fn.pumvisible() == 1 then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
	        elseif luasnip and luasnip.expand_or_jumpable() then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
			else
				fallback()
			end
		end,
	},

	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lua' },
		{ name = 'luasnip' },
		{ name = 'path' },
		{ name = 'buffer'},
		{ name = 'emoji'},
	},

}

