local border = require"general.utils".border

local signs = { Error = " ", Warn = " ", Hint = "", Info = "", other = "﫠" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

vim.lsp.handlers["textDocument/hover"] =  vim.lsp.with( vim.lsp.handlers.hover, {border = border})
vim.lsp.handlers["textDocument/signatureHelp"] =  vim.lsp.with( vim.lsp.handlers.signature_help, {border = border})
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics,{ virtual_text = false})

local luadev = require "lua-dev".setup {
	library = {
		vimruntime = true,
		types = true,
		plugins = false,
    },
}

require("nvim-lsp-installer").on_server_ready(function(server)
	local opts = server.name == "sumneko_lua" and luadev or {}
    server:setup(opts)
end)
