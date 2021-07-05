
require'lspinstall'.setup()

local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
	if server ~= 'lua' then

		require'lspconfig'[server].setup{
			handlers = {
				["textDocument/publishDiagnostics"] = vim.lsp.with(
					vim.lsp.diagnostic.on_publish_diagnostics, {
						virtual_text = false
					}
				),
			}
		}
	end
end

local sumneko_root_path = vim.fn.stdpath('data').. "/lspinstall/lua"
local sumneko_binary = sumneko_root_path .. "/sumneko-lua-language-server"

require 'lspconfig'.sumneko_lua.setup {
	handlers = {
		["textDocument/publishDiagnostics"] = vim.lsp.with(
			vim.lsp.diagnostic.on_publish_diagnostics, {
				virtual_text = false
			}
		),
	},
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
	filetypes = {'lua'},
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {'vim'},
			},
		}
	}
}
