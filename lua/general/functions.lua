M = {}
local line = vim.fn.line

-------- twist ----------
function M.swap_bool()
	local c = vim.api.nvim_get_current_line()
	local subs = c:match("true") and c:gsub("true", "false") or c:gsub("false", "true")
	vim.api.nvim_set_current_line(subs)
end
-------------------------

-----On BufEnter---------
function M.on_file_enter()
	-- if vim.api.nvim_win_is_valid(0) and vim.api.nvim_buf_is_loaded(0) then
	if vim.tbl_contains(vim.api.nvim_list_bufs(), vim.api.nvim_get_current_buf()) then
		if not vim.tbl_contains({"help", "packer", "toggleterm"}, vim.bo.ft) then
			if line [['"]] > 1 and line [['"]] <= line("$") then
				vim.cmd [[norm '"]]
			end
		end
	end
end
-------------------------

-----Go To URL-------
function M.go_to_url()
    local url = vim.fn.expand('<cWORD>')
	if not string.match(url, 'http') then url = "https://github.com/"..url end

    require'notify'("Going to "..url, 'info', {title="Opening browser..."})
    vim.cmd(':silent !xdg-open '..url..' 1>/dev/null')
end
-- 'https://github.com'
---------------------

return M
