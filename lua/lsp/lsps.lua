require'lspinstall'.setup() -- important

-- local on_attach = function(client, bufnr)
--   vim.cmd('autocmd CursorHold <buffer> lua vim.lsp.buf.hover()')
-- end

local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
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
