local luasnip = require'luasnip'
local map = vim.api.nvim_set_keymap

vim.o.completeopt = "menuone,noselect"
require'compe'.setup {
	enabled = true;
	autocomplete = true;
	debug = false;
	min_length = 1;
	preselect = 'enable';
	throttle_time = 80;
	source_timeout = 200;
	incomplete_delay = 400;
	max_abbr_width = 100;
	max_kind_width = 100;
	max_menu_width = 100;
	documentation = false;

	source = {
		path = true;
		buffer = true;
		calc = true;
		luasnip = true;
		nvim_lsp = true;
		nvim_lua = true;
		spell = false;
		tags = true;
		treesitter = true;
		neorg = true;
	};
}

local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
	local col = vim.fn.col('.') - 1
	if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
		return true
	else
		return false
	end
end

_G.tab_complete = function()
	if luasnip and luasnip.expand_or_jumpable() then
		return t "<Plug>luasnip-expand-or-jump"
	elseif vim.fn.pumvisible() == 1 then
		-- vim.fn['compe#confirm']()
		return t "<C-n>"
	elseif check_back_space() then
		return t "<Tab>"
	else
		return vim.fn['compe#complete']()
	end
end
_G.s_tab_complete = function()
	if luasnip and luasnip.jumpable(-1) then
		return t "<Plug>luasnip-jump-prev"
	elseif vim.fn.pumvisible() == 1 then
		return t "<C-p>"
	else
		return t "<S-Tab>"
	end
end

map("s", "<Tab>",   "v:lua.tab_complete()", {expr = true})
map("i", "<Tab>",   "v:lua.tab_complete()", {expr = true})
map("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
map("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- map("i", "<C-y>", "<cmd>call compe#confirm()<CR>", {noremap=true})
-- map("s", "<C-y>", "<cmd>call compe#confirm()<CR>", {noremap=true})

