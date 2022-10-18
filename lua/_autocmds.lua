--> Wrapper funcs
local command = function(name, fn, desc) vim.api.nvim_create_user_command(name, fn, {desc=desc}) end
local au = function(events, ptn, cb)
    local opts = {pattern=ptn}
    opts[type(cb) == "function" and 'callback' or 'command'] = cb
    vim.api.nvim_create_autocmd(events, opts)
end

-->  NEW
au("BufReadPost", "_packer.lua,init.lua", [[call matchadd("Keyword", "--> \\zs.*\\ze$")]])
au("BufEnter", "*", 'set fo-=cro')
au("FileType", "markdown", function() vim.opt_local.spell=true end)
au("FileType", "json", function() vim.opt_local.cole=0 end)
au("VimEnter", "*", function() require("_utils").load_proj_config() end)
-- au("VimEnter", "*", function() require("duck").hatch() end)

--> LSP Related
au("BufWritePre", "*.js,*.jsx,*.ts,*.tsx", function() vim.lsp.buf.format() end)
au("BufWritePre", "*.rs,*.svelte", function() vim.lsp.buf.format() end)
au("CursorHold", "*", vim.diagnostic.open_float)

--> OLD
au("BufReadPost", "*", function() require("essentials").last_place() end)
au("TextYankPost", "*", function() vim.highlight.on_yank({higroup="Folded", timeout=200}) end)
-- au("BufEnter", "*.toml", "set ft=dosini")
-- au("BufWritePost", "_packer.lua", "so | PackerCompile<CR>")
au("TermOpen", "term://*", "setl nonu nornu | star")

--> Commands
command("Format", vim.lsp.buf.format, "Formats the current buffer.")
command("X", ":silent !xset r rate 169 69", "Keyboards press-release rate.")
-- vim.cmd [[syntax keyword Keyword lambda conceal cchar=λ]] -- TODO: (maybe with ts queries?)
