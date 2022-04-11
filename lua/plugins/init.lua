local M = {}

M.staline = function()
	-->             ⌬  | left   :           | right  :            | toggle:  
	require('stabline').setup {
		style = "bar",
		stab_left = "",
		fg = "#986fec",
		bg = "none",
		inactive_bg = "none",
		padding = 2
	}

	require("staline").setup {

		sections = {
			left = { '  ', 'mode', ' ', 'branch', '  ⌬  ', 'lsp' },
			mid = { 'file_name', '%<', },
			right = {
				function() return vim.b.gitsigns_status or "" end,
				function() return vim.b.bookmark_toggled or "" end,
				'    %l/%L  :%c    ',
				function()
					local chars = { "_", "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
					local line_ratio = vim.fn.line(".") / vim.fn.line("$")
					local index = math.ceil(line_ratio * #chars)
					return chars[index]
				end, ' '
			},
		},
		mode_colors = { n = "#94c461" },

		defaults = {
			true_colors = true,
			line_column = " [%l/%L] :%c  ",
			branch_symbol = " ",
		}
	}
end

M.tokyodark = function(transparent)
	-- TODO: NOICE COLOR PALETTE (might port in future)
	-- "#c678dd", "#986fec", "#c882e7", "#5af78e", "#98c379", "#7eca9c",
	-- "#56b6c2", "#61afef", "#8485ce", "#ebcb8b", "#fff94c", "#ffcc00",
	-- "#fca2aa", "#e27d60", "#e86671", "#f7768e",
	-- "#ffffff", "#dddddd", "#999999", "#5c6370",
	-- "#282c34", "#24283b", "#11121d", "#1f1f1f",

	vim.g.tokyodark_transparent_background = transparent and true or false
	vim.g.tokyodark_enable_italic = true

	-- vim.cmd [[colo tokyodark]]
	require("tokyodark").colorscheme()
	vim.cmd [[hi! link IndentBlanklineChar Comment]]
	-- vim.cmd [[hi FloatBorder guibg=#11121d]]
end

M.luasnip = function()
	vim.schedule(function()
		local prints = {
			rust = [[println!("{${0}}");]],
			python = [[print(${0})]],
			javascript = [[console.log(${0});]],
			svelte = [[console.log(${0});]],
			lua = [[print(${0})]],
			c = [[printf("${0}");]],
			cpp = [[std::cout << ${0} << std::endl;]]
		}

		local ls = require'luasnip'
		local parse = ls.parser.parse_snippet

		ls.add_snippets(nil, {
			all = {
				parse({trig="#!", wordTrig=true}, "#!/usr/bin/env ${0}"),
				parse({trig="pp", wordTrig=true}, prints[vim.bo.ft] or "oh shiet"),
			}
		})
	end)
end

M.nvim_tree = function()
	require "nvim-tree".setup {
		disable_netrw = true,
		hijack_netrw = true,
		actions = { open_file = { quit_on_open = true } },
		ignore_ft_on_startup = {'dashboard', 'noiceboard'},
		filters = { custom = { '.git', 'node_modules', '.cache', '__pycache__' } },
		renderer = { indent_markers = { enable = true } },
		view = {
			mappings = {
				list = {
					{ key = "za", action = "edit" },
					{ key = "?", action = "toggle_help" }
				}
			}
		}
	}
end

M.telescope = function()
	require('telescope').setup{
		defaults = {
			vimgrep_arguments = {
				'rg', '--no-heading', '--with-filename', '--line-number', '--column', '--smart-case'
			},
			prompt_prefix = "   ",
			selection_caret = " ",
			entry_prefix = "  ",
			selection_strategy = "reset",
			sorting_strategy = "ascending",
			layout_config = {
				horizontal = { mirror = false },
				vertical = { mirror = false },
			},
			file_ignore_patterns = {'__pycache__', 'node_modules'},
			winblend = 0,
			path_display = {},
			-- set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
		}
	}
end

function M.indent_blankline()
	require("indent_blankline").setup{
		char = "▏", -- 
		show_current_context = true,
		strict_tabs = true,
		filetype_exclude = {
			"terminal", "dashboard", "lsp-installer", "packer"
		},
		buftype_exclude = { "terminal", "norg" }
	}
end

M.neorg = function()
	require('neorg').setup {
		load = {
			["core.norg.completion"] = { config={ engine="nvim-cmp" } },
			["core.defaults"] = {},
			["core.norg.concealer"] = { config = { icon_preset = "diamond" } },
			-- ["core.integrations.telescope"] = {},
			["core.integrations.treesitter"] =  { config = { public={ configure_parsers=true } } },
		},
	}
end

M.treesitter = function()
	require('nvim-treesitter.configs').setup {
		ensure_installed = { "norg" ,"lua", "comment" },
		highlight = { enable = true },
		indent = { enable = true },
	}
end

return M
