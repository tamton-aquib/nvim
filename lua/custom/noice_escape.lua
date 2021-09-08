-- NOTE: this does not work as intended. The timer functions are useless as of now
M = {}
local uv = vim.loop
local Flag = false

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function M.start_listening()
	local col = vim.fn.col('.') - 1
	local prev = vim.api.nvim_get_current_line():sub(col, col)
	local timer = uv.new_timer()

	if vim.v.char == "j" then
		timer:start(200, 0, function ()
			Flag = true
		end)
	elseif vim.v.char == "k" and prev == "j" then
		if Flag == false then
			vim.api.nvim_feedkeys(t("<Esc>"), 'n', true)
			vim.schedule(function() vim.cmd [[norm xx]] end)
			timer:stop()
			Flag = false
		end
	end

	if vim.v.char ~= "k" or vim.v.char ~="j" then
		Flag = false
		timer:stop()
		timer:close()
	end
end

function M.setup()
	for k in pairs(package.loaded) do if k:match("^better_escape") then package.loaded[k] = nil end end
	vim.cmd [[au InsertCharPre * lua require "custom.noice_escape".start_listening()]]
end

return M
