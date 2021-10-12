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
local check_back_space = function()
  local col = vim.fn.col '.' - 1
  return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' ~= nil
end

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

cmp.setup {
	formatting ={
		format = function(_, item)
			item.kind = icons[item.kind] or "noice"
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
		-- ['<C-n>'] = cmp.mapping.select_next_item(),
		-- ['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),

		["<Tab>"] = cmp.mapping(function(fallback)
			-- if vim.fn.pumvisible() == 1 then
			if cmp.visible() then
				-- vim.fn.feedkeys(t("<C-n>"), "n")
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif check_back_space() then
				vim.fn.feedkeys(t("<Tab>"), "n")
			else
				fallback()
			end
		end, { "i", "s", }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			-- if vim.fn.pumvisible() == 1 then
			if cmp.visible() then
				-- vim.fn.feedkeys(t("<C-p>"), "n")
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)

			else
				fallback()
			end
		end, { "i", "s", }),
	},

	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'nvim_lua' },
		{ name = 'luasnip' },
		{ name = 'path' },
		{ name = 'buffer'},
		{ name = 'emoji'},
		{ name = 'neorg'},
	},
	experimental = {
		ghost_text = true,
		custom_menu = true
	}
}
