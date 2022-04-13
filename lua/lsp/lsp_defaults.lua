local border = require("general.utils").border
local signs = { Error = "", Warn  = "", Hint  = "", Info  = "", other = "﫠" }

for name, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. name
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = '' })
end

vim.lsp.handlers["textDocument/hover"] =  vim.lsp.with( vim.lsp.handlers.hover, {border = border})
vim.lsp.handlers["textDocument/signatureHelp"] =  vim.lsp.with( vim.lsp.handlers.signature_help, {border = border})

vim.diagnostic.config({
	virtual_text = false,
	underline = {Error=true},
	float = {
		border = border,
		header = { "  Diagnostics", "String" },
		focusable = false,
		prefix = function(_, _, _)
			return " " , "String" -- icons:        ﬌  
		end
	}
})
