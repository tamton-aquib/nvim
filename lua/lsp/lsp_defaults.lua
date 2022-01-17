local border = require("general.utils").border
local signs = {
	{ name = "Error", icon = " " },
	{ name = "Warn" , icon = " " },
	{ name = "Hint" , icon = ""  },
	{ name = "Info" , icon = ""  },
	{ name = "other", icon = "﫠" }
}

for _, sign in ipairs(signs) do
	local hl = "DiagnosticSign" .. sign.name
	vim.fn.sign_define(hl, { text = sign.icon, texthl = hl, numhl = '' })
end

vim.lsp.handlers["textDocument/hover"] =  vim.lsp.with( vim.lsp.handlers.hover, {border = border})
vim.lsp.handlers["textDocument/signatureHelp"] =  vim.lsp.with( vim.lsp.handlers.signature_help, {border = border})

vim.diagnostic.config({
	virtual_text = false,
	underline={Error=true},
	signs = true,
	float = {
		border = border,
		header = { "律 Diagnostics", "String" },
		focusable = false,
		prefix = function(_, _, _)
			-- local hl = "Diagnostic"..signs[diagnostic.severity].name
			-- local icon = signs[diagnostic.severity].icon
			return " " , "String" -- icons:        ﬌  
		end
	}
})

-- local luadev = require("lua-dev").setup {
	-- library = {
		-- vimruntime = true,
		-- types = true,
		-- plugins = true,
    -- },
-- }

-- require("nvim-lsp-installer").on_server_ready(function(server)
	-- local opts = {}
	-- -- local opts = server.name == "sumneko_lua" and luadev or {}
-- 
	-- if server.name == "rust_analyzer" then
		-- opts = {flags = { exit_timeout = false }}
	-- elseif server.name == "sumneko_lua" then
		-- opts = require("lua-dev").setup {
				-- lspconfig = {
					-- settings = {
						-- Lua = {
							-- diagnostics = {
								-- globals = {"vim"}
							-- }
						-- }
					-- }
				-- },
				-- library = {
					-- vimruntime = true,
					-- types = true,
					-- plugins = true,
				-- },
			-- }
	-- end
	-- server:setup(opts)
-- end)

-- require"lspconfig".sumneko_lua.setup(luadev)
