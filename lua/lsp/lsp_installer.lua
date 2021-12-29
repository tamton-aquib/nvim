local luadev = require("lua-dev").setup {
	library = {
		vimruntime = true,
		types = true,
		plugins = true,
    },
}

require("nvim-lsp-installer").on_server_ready(function(server)
	local opts = {}
	-- local opts = server.name == "sumneko_lua" and luadev or {}

	if server.name == "rust_analyzer" then
		server:setup({flags = { exit_timeout = false }})
	elseif server.name ~= "sumneko_lua" then
		server:setup(opts)
	end
end)

require"lspconfig".sumneko_lua.setup(luadev)
