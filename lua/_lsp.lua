local Lsp = {}
local border = require("_utils").border

Lsp.cmp = function()
    local cmp = require('cmp')

    local source_names = { nvim_lsp = "[LSP]", emoji = "[Emoji]", path = "[Path]", luasnip = "[Snippet]", buffer = "[Buffer]", nvim_lsp_signature_help = "[sig_help]" }
    local kind_icons = {
        Text = ' ', Method = ' ', Function = ' ', Constructor = ' ', Field = ' ', Variable = ' ', Class = ' ', Interface = ' ',
        Module = ' ', Property = ' ', Unit = ' ', Value = ' ', Enum = ' ', Keyword = ' ', Snippet = ' ', Color = ' ', File = ' ',
        Reference = ' ', Folder = ' ', EnumMember = ' ', Constant = ' ', Struct = ' ', Event = ' ', Operator = ' ', TypeParameter = ' ',
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
        window = { documentation = { border = "shadow" } },

        snippet = {
            expand = function(args) require("luasnip").lsp_expand(args.body) end,
        },

        mapping = cmp.mapping.preset.insert {
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-b>'] = cmp.mapping.scroll_docs(-1),
            ['<C-f>'] = cmp.mapping.scroll_docs(1),
            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
        },

        sources = cmp.config.sources {
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
end

Lsp.init = function()
    local signs = { Error = "", Warn  = "", Hint  = "", Info  = "", other = "﫠" }

    for name, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. name
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
    end

    vim.lsp.handlers["textDocument/hover"] =  vim.lsp.with( vim.lsp.handlers.hover, {border = border})
    vim.lsp.handlers["textDocument/signatureHelp"] =  vim.lsp.with( vim.lsp.handlers.signature_help, {border = border})

    vim.diagnostic.config({
        virtual_text = false,
        underline = {Error=true},
        float = {
            border = border,
            header = { "  Diagnostics", "String" },
            focusable = false,
            prefix = function(_, _, _)
                return " " , "String" -- icons:        ﬌  
            end
        }
    })
end

--> LSP-Installer
Lsp.lsp_installer = function()
    require("nvim-lsp-installer").setup{}
    local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    local s = {
        rust_analyzer = {flags={exit_timeout=false}, capabilities=capabilities},
        sumneko_lua = vim.g.devmode and require("lua-dev").setup{}  or {
            settings = {Lua={diagnostics={globals={"vim"}}}}
        }
    }

    local lspconfig = require("lspconfig")
    for server, opt in pairs(s) do
        lspconfig[server].setup(opt)
    end
end

return Lsp
