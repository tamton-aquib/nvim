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
		format = function(entry, item)
			item.kind = icons[item.kind] or "noice"
			-- item.menu = ({
				-- buffer = "[Buffer]",
				-- nvim_lsp = "[LSP]",
				-- luasnip = "n",
				-- nvim_lua = "[Lua]",
			-- })[entry.source.name]
			return item
		end
	},
    documentation = {
		-- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		border = require"general.utils".border,
		-- border = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" },
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
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		-- ['<Tab>'] = function(fallback)
			-- if vim.fn.pumvisible() == 1 then
				-- vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
	        -- elseif luasnip and luasnip.expand_or_jumpable() then
				-- vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
			-- else
				-- fallback()
			-- end
		-- end,

		["<Tab>"] = cmp.mapping(function(fallback)
			if vim.fn.pumvisible() == 1 then
				vim.fn.feedkeys(t("<C-n>"), "n")
			elseif luasnip.expand_or_jumpable() then
				-- vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"), "")
				-- vim.fn.feedkeys(t("<cmd>lua require'luasnip'.expand_or_jump()"), "")
				luasnip.expand_or_jump()
			elseif check_back_space() then
				vim.fn.feedkeys(t("<Tab>"), "n")
			else
				fallback()
			end
		end, { "i", "s", }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if vim.fn.pumvisible() == 1 then
				vim.fn.feedkeys(t("<C-p>"), "n")
			elseif luasnip.jumpable(-1) then
				-- vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
				-- vim.fn.feedkeys(t("<cmd>lua require'luasnip'.jump(-1)"), "")
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
	},

}

