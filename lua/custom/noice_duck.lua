-- NOTE: this doesnt mess with the current buffer (which means: release the duck when coding :kek:)
-- NOTE: release the duck with require("duck").hatch()
-- NOTE: default mapping to cook(stop): <leader>k (require"duck".cook())
-- TODO: stop timer before quitting the window? 🤔
local M = {}
local character = "🦆"  -- ඞ🐈🐎 🦖 🐤
local wreckage = false

-- TODO: wreak havoc level: 🦆
-- TODO: maybe a function to drag it to center
local wreck = function(config)
	local col, row = config["col"][false], config["row"][false]
	print(col, row)
	-- if (0 < col) and (col < vim.o.columns) and (0 < row) and (row < vim.o.lines)  then
	if (0 < row) and (row < vim.o.lines) then
		vim.api.nvim_win_set_cursor(0, {row, col})
	end
end

local waddle = function(win)
	local timer = vim.loop.new_timer()
	vim.loop.timer_start(timer, 1000, 100, vim.schedule_wrap(function()
		if vim.api.nvim_win_is_valid(win) then
			-- TODO: restrict movement inside walls
			local config = vim.api.nvim_win_get_config(win)
			local col, row = config["col"][false], config["row"][false]
			local movement = math.ceil(math.random()*4)
			if wreckage == true then wreck(config) end

			math.randomseed(os.time())
			if movement == 1 or row <= 0 then
				config["row"] = row + 1
			elseif movement == 2 or row >= vim.o.lines-1 then
				config["row"] = row - 1
			elseif movement == 3 or col <= 0 then
				config["col"] = col + 1
			elseif movement == 4 or col >= vim.o.columns-2 then
				config["col"] = col - 1
			end
			vim.api.nvim_win_set_config(win, config)
		else
			timer:stop()
			timer:close()
			return
		end
	end))
end

M.hatch = function()
	for k in pairs(package.loaded) do if k:match("^duck") then package.loaded[k] = nil end end
	local buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(buf , 0, 1, true , {character})

	local w, h = vim.o.columns, vim.o.lines
	local win_h, win_w = math.ceil(h * 0.5 - 2), math.ceil(w * 0.5)
	local row = math.ceil((h - win_h) / 2 - 1)
	local col = math.ceil((w - win_w) / 2)

	local duck = vim.api.nvim_open_win(buf, false, {
		relative='win', style='minimal', row=row, col=col, width=2, height=1
	})
	vim.api.nvim_win_set_option(duck, 'winblend', 100)
	-- vim.api.nvim_win_set_option(duck, 'winhighlight', 'Normal:Duck')
	-- vim.cmd [[hi Duck guifg=red guibg=green]]
	vim.api.nvim_set_keymap(
		'n', '<leader>k',
		':lua require("custom.noice_duck").cook('..duck..')<CR>',
		{noremap=true, silent=true}
	)

	waddle(duck)
end

M.cook = function(win) vim.api.nvim_win_close(win, true) end

return M
