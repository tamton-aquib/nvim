
require'lspinstall'.setup()

local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do
	if server ~= 'lua' then

		require'lspconfig'[server].setup{}
	end
end

local sumneko_root_path = vim.fn.stdpath('data').. "/lspinstall/lua"
local sumneko_binary = sumneko_root_path .. "/sumneko-lua-language-server"

require 'lspconfig'.sumneko_lua.setup {
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

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = false
	}
)

local signs = { Error = "", Warning = " ", Hint = "", Information = "", other = "﫠" }
for type, icon in pairs(signs) do
	local hl = "LspDiagnosticsSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- vim.lsp.protocol.CompletionItemKind = {
--     '',
--     'ƒ',
--     '',
--     '',
--     '',
--     '',
--     'ﰮ',
--     '',
--     '',
--     '',
--     '',
--     '了',
--     '',
--     '﬌',
--     '',
--     '',
--     '',
--     '',
--     '',
--     '',
--     '',
--     '',
--     ''
-- }
vim.lsp.protocol.CompletionItemKind = {
  "    ",
  "   ",
  "   ",
  "   ",
  " ﴲ  ",
  "[] ",
  "   ",
  " ﰮ  ",
  "   ",
  " 襁 ",
  "   ",
  "   ",
  " 練 ",
  "   ",
  " ﬌  ",
  "   ",
  "   ",
  "   ",
  "   ",
  "   ",
  " ﲀ  ",
  " ﳤ  ",
  "   ",
  "   ",
  "   "
}

