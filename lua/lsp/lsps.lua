local border = require"general.utils".border
local signs = { Error = " ", Warning = " ", Hint = "", Information = "", other = "﫠" }

for type, icon in pairs(signs) do
	local hl = "LspDiagnosticsSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

local on_attach = function(_, _)
	vim.lsp.handlers["textDocument/hover"] =  vim.lsp.with(
		vim.lsp.handlers.hover, {border = border})
	vim.lsp.handlers["textDocument/signatureHelp"] =  vim.lsp.with(
		vim.lsp.handlers.signature_help, {border = border})
	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
		vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
	)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
        'documentation',
        'detail',
        'additionalTextEdits',
    }
}

require'lspmanager'.setup()

local servers = require'lspmanager'.installed_servers()
for _, server in pairs(servers) do
	if server ~= 'sumneko_lua' then
		require'lspconfig'[server].setup{
			on_attach = on_attach,
			capabilities = capabilities
		}
	end
end

-- local sumneko_root_path = vim.fn.stdpath('data').. "/lspinstall/lua"
-- local sumneko_binary = sumneko_root_path .. "/sumneko-lua-language-server"

local sumneko_root_path = vim.fn.stdpath('data').. "/lspmanager/sumneko_lua"
local sumneko_binary = sumneko_root_path .. "/sumneko-lua-language-server"

local luadev = require "lua-dev".setup {
	library = {
		vimruntime = true,
    	types = true,
    	plugins = false,
    },
	lspconfig = {
		on_attach = on_attach,
		cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
		filetypes = {'lua'},
		settings = {
			Lua = {
				diagnostics = {
					globals = {'vim'},
				},
				telemetry = { enable = false },
			}
		}
	}
}

require 'lspconfig'.sumneko_lua.setup(luadev)
