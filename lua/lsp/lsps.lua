
vim.cmd [[au CursorHoldI * lua vim.lsp.buf.signature_help({focusable=false})]]
-- vim.cmd [[au CursorHold * lua vim.lsp.buf.hover()]]
vim.cmd [[au CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics({border = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" }, focusable=false})]]

local signs = { Error = " ", Warning = " ", Hint = "", Information = "", other = "﫠" }
for type, icon in pairs(signs) do
	local hl = "LspDiagnosticsSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

local border = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏"}

local on_attach = function(_, _)
	vim.lsp.handlers["textDocument/hover"] =  vim.lsp.with(
		vim.lsp.handlers.hover, {border = border})
	vim.lsp.handlers["textDocument/signatureHelp"] =  vim.lsp.with(
		vim.lsp.handlers.signature_help, {border = border})
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)

require'lspinstall'.setup()

local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
	if server ~= 'lua' then
		require'lspconfig'[server].setup{
			on_attach = on_attach
		}
	end
end

local sumneko_root_path = vim.fn.stdpath('data').. "/lspinstall/lua"
local sumneko_binary = sumneko_root_path .. "/sumneko-lua-language-server"

require 'lspconfig'.sumneko_lua.setup {
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
