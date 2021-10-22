local border = require"general.utils".border

local signs = { Error = " ", Warn = " ", Hint = "", Info = "", other = "﫠" }

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

require("lspmanager").setup({sumneko_lua=nil})

vim.lsp.handlers["textDocument/hover"] =  vim.lsp.with( vim.lsp.handlers.hover, {border = border})
vim.lsp.handlers["textDocument/signatureHelp"] =  vim.lsp.with( vim.lsp.handlers.signature_help, {border = border})
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with( vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false })

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { 'documentation', 'detail', 'additionalTextEdits' }
}

local bin = '/home/taj/.local/share/nvim/lspmanager/sumneko_lua/extension/server/bin/Linux/lua-language-server'
local main = '/home/taj/.local/share/nvim/lspmanager/sumneko_lua/extension/server/main.lua'
local luadev = require "lua-dev".setup {
	library = {
		vimruntime = true,
    	types = true,
    	plugins = false,
    },
	lspconfig = {
		cmd = { bin, '-E', main },
		capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities()),
		-- on_attach = on_attach,
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
