M = {}

local opts = { noremap = true, silent = true }
local line = vim.fn.line

------ Timing scheme --------
function M.timing_scheme()
    local hour = tonumber(os.date("%H"))
    local colo = ""
    if hour <= 12 then
		colo = "noice"
    elseif hour <= 20 then
		colo = "tokyonight"
    else
		colo = "sonokai"
    end
    require"themes.colorschemes"[colo](false)
end

-- cmd [[au BufEnter * lua Timing_scheme()]]
-----------------------------

-------- twist ----------
function M.swap_bool()
	local c = vim.api.nvim_get_current_line()
	local subs = c:match("true") and c:gsub("true", "false") or c:gsub("false", "true")
	vim.api.nvim_set_current_line(subs)
end
-------------------------

-----On BufEnter---------
function M.on_file_enter()
    if line([['"]]) > 1 and line([['"]]) <= line("$") then
		vim.cmd [[norm '"]]
    end
end
-------------------------

-----Go To URL-------
function M.go_to_url(nice)
    local url = vim.fn.expand('<cWORD>')
	url = nice and "https://github.com/"..url or url
    require'notify'("Going to "..url, 'info', {title="Noice"})
    vim.cmd(':silent !xdg-open '..url..' 1>/dev/null')
end
-- 'https://github.com'
---------------------

----Packer Reload----
function M.packer_do_everything()
    vim.cmd [[w]]
    vim.cmd [[luafile ~/.config/nvim/lua/general/packer.lua]]
    vim.cmd [[PackerSync]]
    -- require'notify'("Updating Plugins", 'info', {title="Packer"})
end
---------------------

--------Transparent Toggle-------------
local is_tranparent = 0
function M.toggle_transparent()
    if (is_tranparent == 1) then
		vim.cmd('hi Normal guibg=NONE ctermbg=NONE')
		is_tranparent = 0
    else
		vim.o.background = "dark"
		is_tranparent = 1
    end
end
---------------------------------------

return M
