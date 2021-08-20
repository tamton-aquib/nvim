local cmp = require('cmp')


local icons = {
	Class = " ",
	Color = " ",
	Constant = " ",
	Constructor = " ",
	Enum = "了 ",
	EnumMember = " ",
	Field = " ",
	File = " ",
	Folder = " ",
	Function = " ",
	Interface = "ﰮ ",
	Keyword = " ",
	Method = "ƒ ",
	Module = " ",
	Property = " ",
	Snippet = "﬌ ",
	Struct = " ",
	Text = " ",
	Unit = " ",
	Value = " ",
	Variable = " ",
}


cmp.setup {
	formatting ={
		format = function(entry, item)
			item.kind = icons[item.kind]
			return item
		end
	},
    -- You must set mapping.
	mapping = {
		['<S-Tab>'] = cmp.mapping.prev_item(),
		['<Tab>'] = cmp.mapping.next_item(),
		['<C-d>'] = cmp.mapping.scroll(-4),
		['<C-f>'] = cmp.mapping.scroll(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		})
	},

	-- You should specify your *installed* sources.
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'path' },
		{ name = 'buffer'},
	},

	documentation = true
}

