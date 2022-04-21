local command = function(name, fn, desc) vim.api.nvim_create_user_command(name, fn, {desc=desc}) end
local au = function(events, ptn, cb, once) vim.api.nvim_create_autocmd(events, {pattern=ptn, callback=cb, once=once}) end

-->  NEW
au("BufEnter", "_packer.lua,init.lua", function() vim.fn.matchadd("Keyword", "--> \\zs.*\\ze$") end)
au("BufEnter", "*", function() vim.opt_local.fo:remove{'c', 'r', 'o'} end)
au("FileType", "markdown", function() vim.opt_local.spell=true end)
au("FileType", "json", function() vim.opt_local.cole=0 end)
au("DiagnosticChanged", "*", function() vim.notify("Lsp Started!") end, true)
-- au("VimEnter", "*", require("duck").hatch)

--> LSP Related
au("BufWritePre", "*.js,*.jsx", function() vim.lsp.buf.formatting_sync(nil, 200) end)
au("BufWritePre", "*.rs,*.svelte", function() vim.lsp.buf.formatting_sync(nil, 1000) end)
au("CursorHold", "*", function() vim.diagnostic.open_float() end)

--> OLD
au("BufReadPost", "*", function() require("essentials").last_place() end)
au("TextYankPost", "*", function() vim.highlight.on_yank({higroup="Folded", timeout=200}) end)
au("BufEnter", "*.toml", function() vim.opt_local.ft="dosini" end)
au("FileType", "help", function() vim.cmd[[nn <buffer> <CR> <C-]>]] end)
au("BufWritePost", "_packer.lua", function() vim.cmd"so | PackerCompile<CR>" end)
au("TermOpen", "term://*", function() vim.cmd "setl nonu nornu | star" end)

--> Commands
command("Format", vim.lsp.buf.formatting, "Formats the current buffer.")
command("X", ":silent !xset r rate 169 69", "Keyboards press-release rate.")
-- vim.cmd [[syntax keyword Keyword lambda conceal cchar=λ]] -- TODO: (maybe with ts queries?)