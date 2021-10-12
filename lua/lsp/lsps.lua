local border = require"general.utils".border

local signs = { Error = " ", Warn = " ", Hint = "", Info = "", other = "﫠" }

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
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
    properties = { 'documentation', 'detail', 'additionalTextEdits' }
}

-- local lsp_installer = require("nvim-lsp-installer")
-- lsp_installer.on_server_ready(function(server)
    -- local opts = {
		-- capabilities = capabilities,
		-- on_attach = on_attach
	-- }

    -- server:setup(opts)
    -- vim.cmd [[ do User LspAttachBuffers ]]
-- end)

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
		on_attach = on_attach,
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
