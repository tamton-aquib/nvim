local cmp = require('cmp')

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
    Snippet = ' ',
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
    window = { documentation = { border = require("general.utils").border } },

    snippet = {
        expand = function(args) require("luasnip").lsp_expand(args.body) end,
    },

    mapping = {
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-1),
        ['<C-f>'] = cmp.mapping.scroll_docs(1),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
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

    experimental = { ghost_text = true }
}

cmp.setup.cmdline(':', { sources = {{name="cmdline", keyword_length=3}} })
