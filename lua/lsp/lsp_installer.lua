local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local on_attatch = function()
	vim.keymap.set('n', 'gd',    vim.lsp.buf.definition, {})
	vim.keymap.set('n', 'gD',    vim.lsp.buf.declaration, {})
	vim.keymap.set('n', 'gr',    vim.lsp.buf.references, {})
	vim.keymap.set('n', 'gi',    vim.lsp.buf.implementation, {})
	vim.keymap.set('n', 'gh',    vim.lsp.buf.hover, {})
	vim.keymap.set('n', '<M-n>', vim.diagnostic.goto_next, {})
	vim.keymap.set('n', '<M-p>', vim.diagnostic.goto_prev, {})
end

require("nvim-lsp-installer").on_server_ready(function(server)
	local opts = { capabilities = capabilities, on_attatch=on_attatch }

	if server.name ~= "rust_analyzer" then
		if server.name == "sumneko_lua" then
			opts = vim.g.devmode and require("lua-dev").setup{} or {}
		end
	end

	server:setup(opts)
end)
