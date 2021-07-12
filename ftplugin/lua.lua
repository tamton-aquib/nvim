
local sumneko_root_path = vim.fn.stdpath('data').. "/lspinstall/lua"
local sumneko_binary = sumneko_root_path .. "/sumneko-lua-language-server"

require 'lspconfig'.sumneko_lua.setup {
	on_attach = function(client, bn)
		require'lsp_signature'.on_attach(client)
	end,
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
	filetypes = {'lua'},
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = {'vim'},
			},
			telemetry = { enable = false },
		}
	}
}

