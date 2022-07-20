--> Wrapper funcs
local command = function(name, fn, desc) vim.api.nvim_create_user_command(name, fn, {desc=desc}) end
local au = function(events, ptn, cb, once) vim.api.nvim_create_autocmd(events, {pattern=ptn, callback=cb, once=once}) end

-->  NEW
au("BufEnter", "_packer.lua,init.lua", function() vim.fn.matchadd("Keyword", "--> \\zs.*\\ze$") end)
au("BufEnter", "*", function() vim.cmd'setlocal fo-=cro' end)
au("FileType", "markdown", function() vim.opt_local.spell=true end)
au("FileType", "json", function() vim.opt_local.cole=0 end)
au("DiagnosticChanged", "*", function() vim.notify("  Lsp Started!") end, true)
au("DirChanged", "*", function() require("_utils").load_proj_config() end)
-- au("VimEnter", "*", function() require("duck").hatch() end)

--> LSP Related
au("BufWritePre", "*.js,*.jsx,*.ts,*.tsx", function() vim.lsp.buf.format() end)
au("BufWritePre", "*.rs,*.svelte", function() vim.lsp.buf.format() end)
-- au("CursorHold", "*", vim.diagnostic.open_float)

--> OLD
au("BufReadPost", "*", function() require("essentials").last_place() end)
au("TextYankPost", "*", function() vim.highlight.on_yank({higroup="Folded", timeout=200}) end)
au("BufEnter", "*.toml", function() vim.opt_local.ft="dosini" end)
au("BufWritePost", "_packer.lua", function() vim.cmd"so | PackerCompile<CR>" end)
au("TermOpen", "term://*", function() vim.cmd "setl nonu nornu | star" end)

--> Commands
command("Format", vim.lsp.buf.formatting, "Formats the current buffer.")
command("X", ":silent !xset r rate 169 69", "Keyboards press-release rate.")
-- vim.cmd [[syntax keyword Keyword lambda conceal cchar=λ]] -- TODO: (maybe with ts queries?)
