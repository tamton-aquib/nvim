local M = {}

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
	vim.g.nvim_tree_indent_markers = 1

	require "nvim-tree".setup {
		disable_netrw = true,
		hijack_netrw = true,
		actions = {
			open_file = {
				quit_on_open = true,
			},
		},
		ignore_ft_on_startup = {'dashboard', 'noiceboard'},
		filters = {
			custom = { '.git', 'node_modules', '.cache', '__pycache__' }
		},
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
			"terminal", "dashboard", "NvimTree", "help",
			"packer", "lspinfo", "lsp-installer"
		},
		buftype_exclude = { "terminal", "norg" }
	}
end

function M.markdown_preview()
	vim.g.mkdp_refresh_slow = 1
	vim.g.mkdp_auto_close = 0
end

M.neorg = function()
	require('neorg').setup {
		load = {
			["core.norg.completion"] = { config={ engine="nvim-cmp" } },
			["core.defaults"] = {},
			["core.norg.concealer"] = { config = { icon_preset = "diamond" } },
			-- ["core.integrations.telescope"] = {},
			["core.integrations.treesitter"] =  { config = { public={ configure_parsers=true } } },
			-- ["core.norg.dirman"] = {
			-- config = {
			-- workspaces = { my_workspace = "~/neorg" },
			-- }
			-- }
		},
		-- logger = { level = "info" }
	}
end

M.treesitter = function()
	require('nvim-treesitter.configs').setup {
		ensure_installed = { "norg" ,"lua", "comment" },
		highlight = {
			enable = true,
		},
		indent = {
			enable = true
		},
	}
end

return M
