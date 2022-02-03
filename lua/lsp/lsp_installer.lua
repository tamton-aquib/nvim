
require("nvim-lsp-installer").on_server_ready(function(server)
	local opts = {}

	if server.name == "rust_analyzer" then
		opts = {flags = { exit_timeout = false }}
	elseif server.name == "sumneko_lua" then
		opts = require("lua-dev").setup {
			library = {
				vimruntime = true,
				types = true,
				plugins = true,
			}
		}
	end

	server:setup(opts)
end)

