local Lsp = {}
local border = require("_utils").border

Lsp.cmp = function()
    local cmp = require('cmp')
    local luasnip = require("luasnip")

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
            expand = function(args) luasnip.lsp_expand(args.body) end,
        },

        mapping = cmp.mapping.preset.insert {
            ['<C-n>'] = cmp.mapping.select_next_item(),
            ['<C-p>'] = cmp.mapping.select_prev_item(),
            ['<C-b>'] = cmp.mapping.scroll_docs(-1),
            ['<C-f>'] = cmp.mapping.scroll_docs(1),
            ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
            ['<CR>'] = cmp.mapping.confirm({ select = true }),
            ['<Tab>'] = function(fallback)
                if luasnip.jumpable() then luasnip.jump(1) else fallback() end
            end
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

    cmp.setup.cmdline(':', { mapping=cmp.mapping.preset.cmdline(), sources = {{name="cmdline", keyword_length=3}} })
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
            prefix = function(_, _, _) return "  " , "String" end, -- icons:        ﬌  
            suffix = ''
        }
    })
end

--> LSP-Installer
Lsp.setup_servers = function()
    -- local runtime_path = vim.split(package.path, ';')
    -- table.insert(runtime_path, 'lua/?.lua')
    -- table.insert(runtime_path, 'lua/?/init.lua')

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local lspconfig = require("lspconfig")
    local s = {
        sumneko_lua = { settings={Lua={
            diagnostics={globals={'vim'}},
            runtime = {version="LuaJIT"}, -- , path=runtime_path},
            -- workspace = { library = vim.api.nvim_get_runtime_file('', true) },
        }}},
        pyright={}, tsserver={}, svelte={}, clangd={}, zls={}
    }

    for server, opt in pairs(s) do
        opt.capabilities = capabilities
        lspconfig[server].setup(opt)
    end
end

return Lsp
