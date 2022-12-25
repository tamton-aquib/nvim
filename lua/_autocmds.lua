--> Wrapper funcs
local command = function(name, fn, desc) vim.api.nvim_create_user_command(name, fn, {desc=desc}) end
local au = function(events, ptn, cb) vim.api.nvim_create_autocmd(events, {pattern=ptn, [type(cb)=="function" and 'callback' or 'command']=cb}) end

-->  NEW
au("BufReadPost", "_lazy.lua,init.lua", [[call matchadd("Keyword", "--> \\zs.*\\ze$")]])
au("BufEnter", "*", 'setl fo-=cro')
au("FileType", "markdown", function() vim.opt_local.spell=true end)
au("FileType", "json", function() vim.opt_local.cole=0 end)

-->  LSP Related
au("BufWritePre", "*.js,*.jsx,*.ts,*.tsx", function() vim.lsp.buf.format() end)
au("BufWritePre", "*.rs,*.svelte", function() vim.lsp.buf.format() end)
au("CursorHold", "*", vim.diagnostic.open_float)

-->  OLD
au("BufReadPost", "*", function() require("essentials").last_place() end)
au("TextYankPost", "*", function() vim.highlight.on_yank({higroup="Folded", timeout=200}) end)
au("TermOpen", "term://*", "setl nonu nornu | star")

-->  Commands
command("Format", vim.lsp.buf.format, "Formats the current buffer.")
command("X", ":silent !xset r rate 169 69", "Keyboards press-release rate.")
command("PP", require("essentials").null_pointer, {range='%'})
command("Mess", require("_utils").mess, "Message to temp output buf.")
-- vim.cmd [[syntax keyword Keyword lambda conceal cchar=λ]] -- TODO: (maybe with ts queries?)

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        client.server_capabilities.semanticTokensProvider = nil
    end,
});
