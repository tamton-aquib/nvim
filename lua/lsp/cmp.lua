local cmp = require('cmp')
local luasnip = require('luasnip')

local check_back_space = function()
	local col = vim.fn.col '.' - 1
	return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' ~= nil
end

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local source_names = {
	nvim_lsp = "[LSP]",
	emoji = "[Emoji]",
	path = "[Path]",
	luasnip = "[Snippet]",
	buffer = "[Buffer]",
	nvim_lsp_signature_help = "[sig_help]",
}
local kind_icons = {
	Text = ' ',
	Method = ' ',
	Function = ' ',
	Constructor = ' ',
	Field = ' ',
	Variable = ' ',
	Class = ' ',
	Interface = ' ',
	Module = ' ',
	Property = ' ',
	Unit = ' ',
	Value = ' ',
	Enum = ' ',
	Keyword = ' ',
	-- Snippet = ' ',
	Snippet = ' ',
	Color = ' ',
	File = ' ',
	Reference = ' ',
	Folder = ' ',
	EnumMember = ' ',
	Constant = ' ',
	Struct = ' ',
	Event = ' ',
	Operator = ' ',
	TypeParameter = ' ',
}

cmp.setup {
	formatting = {
		fields = { 'kind', 'abbr', 'menu' },
		format = function(entry, item)
			item.kind = kind_icons[item.kind] or " "
			item.menu = source_names[entry.source.name] or " "
			return item
		end
	},
    documentation = {
		border = require"general.utils".border,
		winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
    },

	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},

	mapping = {
		['<C-n>'] = cmp.mapping.select_next_item(),
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(-2), { 'i', 'c' }),
		['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(2), { 'i', 'c' }),
		['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),

		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif check_back_space() then
				vim.fn.feedkeys(t("<Tab>"), "n")
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i", "s" }),
	},

	sources = {
		{ name = 'path' },
		{ name = 'nvim_lsp' },
		{ name = 'nvim_diagnostic' },
		{ name = 'buffer'},
		{ name = 'nvim_lsp_signature_help' },
		{ name = 'nvim_lua' },
		{ name = 'luasnip' },
		{ name = 'emoji'},
		{ name = 'neorg'},
		{ name = 'crates'},
	},

	experimental = {
		ghost_text = true,
		custom_menu = true
	}
}
