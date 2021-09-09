M = {}

-- TODO: break into pieces
local fn = vim.fn
local nb = vim.api.nvim_create_namespace('noiceboard')
local opts = {noremap = true, silent = true}
local buf_map = vim.api.nvim_buf_set_keymap
-- local temp_options = {
	-- nu=false, rnu=false, cuc=false, list=false,
	-- ma=false, mod=false, cul=false, ft='dashboard'
-- }

local keymaps = {
    K = '~/.config/kitty/kitty.conf',
    F = '~/.config/fish/config.fish',
    I = '~/.config/nvim/init.lua',
    A = '~/.config/alacritty/alacritty.yml',
    P = '~/.config/picom/picom.conf'
}

local header = {
    " ▄▄▄█████▓    ▄▄▄          ▄▄▄██▀▀▀ ",
    " ▓  ██▒ ▓▒   ▒████▄          ▒██    ",
    " ▒ ▓██░ ▒░   ▒██  ▀█▄        ░██    ",
    " ░ ▓██▓ ░    ░██▄▄▄▄██    ▓██▄██▓   ",
    "   ▒██▒ ░     ▓█   ▓██▒    ▓███▒    ",
    "   ▒ ░░       ▒▒   ▓▒█░    ▒▓▒▒░    ",
    "     ░         ▒   ▒▒ ░    ▒ ░▒░    ",
    "   ░           ░   ▒       ░ ░ ░    ",
    "                   ░  ░    ░   ░    ",
}

local function center(dict)
    local new_dict = {}
    for _, v in pairs(dict) do
		local padding = fn.max(fn.map(dict, 'strwidth(v:val)'))
		local spacing = (" "):rep(math.floor((vim.o.columns - padding) / 2)) .. v
		table.insert(new_dict, spacing)
	end
    return new_dict
end

local count = 1
local function set_lines(len, text, hi, pass)
    vim.api.nvim_buf_set_lines(0, count, count+len, false, center(text))
    vim.api.nvim_win_set_cursor(0, {count, 0})
    if pass then vim.g.section_length = count end
    for i=count,count+len do
		vim.api.nvim_buf_add_highlight(0, nb, hi, i, 1, -1)
    end
    count = count + len
end

function M.get_line()
    local line = vim.api.nvim_get_current_line()
    local telescope = require'telescope.builtin'
    if line:match("Find Files") then
		telescope.find_files()
    elseif line:match("Colorscheme") then
		telescope.colorscheme()
    elseif line:match("Recent Files") then
		telescope.oldfiles()
    elseif line:match("Find Word") then
		telescope.live_grep()
    end
    vim.api.nvim_set_current_buf(0)
end

-- TODO: break into sections
local d = {
    "   Find Files                       SPC f f", "",
    "   Find Word                        SPC f w", "",
    "   Jump to Bookmarks                SPC f b", "",
    "   Recent Files                     SPC f r", "",
    "   Change Colorscheme               SPC t c", "",
}

function M.set_folder(filename)
    M.Flag = true
    vim.cmd(':e '..filename)
    vim.api.nvim_set_current_dir(
		fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':h')
    )
end

local function set_keymaps_and_options()
    -- TODO: remove these when opening a new buffer
    for key, file in pairs(keymaps) do
	buf_map(
	    0, 'n', key,
	    '<cmd>lua require"custom.noice_board".set_folder("'..file..'")<CR>',
	    opts
	)
    end
    buf_map(0, 'n', '<CR>', '<cmd>lua require"custom.noice_board".get_line()<CR>', opts)
end

local function empty() set_lines(2, {'', ''}, 'String') end

function M.setup()
    if vim.api.nvim_buf_get_name(0) == "" then
		vim.api.nvim_buf_set_option(0, 'bufhidden', 'wipe')

		vim.schedule(function()
			New_buffer = vim.api.nvim_create_buf(false, true)
			vim.api.nvim_win_set_buf(0, New_buffer)

			empty()
			set_lines(#header, header, 'String'); empty() empty()
			set_lines(#d, d, 'Function', true);       empty()
			set_lines(1, {'taj@arch'}, 'Constant')

			-- TODO: set CursorMoved autocmd to make it smooth
			-- vim.cmd [[au CursorMoved * lua require'custom.noice_board'.go_to_line()]]

			set_keymaps_and_options()
			vim.cmd [[silent! setlocal nonu nornu ft=dashboard]]
			-- TODO: clean this part
			vim.api.nvim_win_set_cursor(0, {vim.g.section_length, 0})
			vim.cmd [[norm w]]
		end)
    end
end

return M
