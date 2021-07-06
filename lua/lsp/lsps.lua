
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

-- vim.lsp.protocol.CompletionItemKind ={ " Text", "ƒ Method", " Function", " Constructor", "Field", " Variable", " Class", "ﰮ Interface", " Module", " Property", " Unit", " Value", "了 Enum", " Keyword", "﬌ Snippet", " Color",
--  " File", "Reference", " Folder", " EnumMember", " Constant",
-- " Struct", " Event", " Operator", " TypeParameter" }

-- vim.lsp.protocol.CompletionItemKind = { "", "了", "", "", "", "", "", "", "﬌", "", "", "", "", "", "", "ƒ", "", "", "ﰮ", "", "", "", "" }

-- vim.lsp.protocol.CompletionItemKind = {
--     [2] = "   ",
--     [3] = "   ",
--     [4] = "   ",
--     [5] = "   ",
--     [6] = " ﴲ  (Field)",
--     [7] = "[] ",
--     [8] = "   ",
--     [9] = " ﰮ  (Interface)",
--     [10] = "   ",
--     [11] = " 襁 ",
--     [12] = "   ",
--     [13] = "   ",
--     [14] = " 練 ",
--     [15] = "   ",
--     [16] = "   ",
--     [17] = "   ",
--     [18] = "   ",
--     [19] = "   ",
--     [20] = "   ",
--     [21] = "   ",
--     [22] = " ﲀ  (Constant)",
--     [23] = " ﳤ  (Struct)",
--     [24] = "   ",
--     [25] = "   ",
--     [26] = "   "
-- }

