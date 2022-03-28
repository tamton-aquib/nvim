local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require("nvim-lsp-installer").on_server_ready(function(server)
	local opts = { capabilities = capabilities }

	if server.name ~= "rust_analyzer" then
		if server.name == "sumneko_lua" then
			opts = require("lua-dev").setup {
				library = {
					vimruntime = true,
					types = true,
					plugins = true,
				}
			}
		end
	end

	server:setup(opts)
end)

require("lspconfig").rust_analyzer.setup{}
