local M = {}

M.mkdp = function() vim.g.mkdp_auto_close = 0 end

M.staline = function()
    -->              ⌬  | left   :           | right  :            | toggle:  
    require('stabline').setup { style='slant' }

    require("staline").setup {
        sections = {
            left = { '  ', 'mode', ' ', 'branch', '    ', 'lsp' },
            mid = { '%<', 'file_name' },
            right = {
                function() return vim.b.bookmark or '' end,
                '    %l/%L  :%c    ',
                { 'Staline', function()
                    local chars = { "_", "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
                    local line_ratio = vim.fn.line(".") / vim.fn.line("$")
                    local index = math.ceil(line_ratio * #chars)
                    return chars[index]
                end }, ' '
            },
        },
        defaults = {
            true_colors = true,
            line_column = " [%l/%L] :%c  ",
            branch_symbol = " ",
        },
    }
end

M.devicons = function()
    require("nvim-web-devicons").setup { override={
        norg={icon="", color="#4878BE", name="neorg"},
        rs={icon="🦀",name="Rss"}
    }}
end

M.notify = function()
    require("notify").setup{
        render='minimal',
        background_colour = "#000000"
    }
end

M.tokyodark = function(t)
    -- TODO: NOICE COLOR PALETTE (might port in future)
    -- "#c678dd", "#986fec", "#c882e7", "#5af78e", "#98c379", "#7eca9c",
    -- "#56b6c2", "#61afef", "#8485ce", "#ebcb8b", "#fff94c", "#ffcc00",
    -- "#fca2aa", "#e27d60", "#e86671", "#f7768e",
    -- "#ffffff", "#dddddd", "#999999", "#5c6370",
    -- "#282c34", "#24283b", "#11121d", "#1f1f1f",

    vim.g.tokyodark_transparent_background = t and true or false
    vim.g.tokyodark_enable_italic = true

    vim.cmd.colorscheme "tokyodark"
end

M.luasnip = function()
    local ls = require('luasnip')
    local parse = ls.parser.parse_snippet

	local snips = {
		lua = 'vim.pretty_print(${0})',
		python = 'print("${0}")',
		rust = 'println!("${0}");',
		c = 'printf("${0}");', cpp = 'std::cout << "${0}" << std::endl;',
		javascript = 'console.log("${0}");', typescript = 'console.log("${0}");',
	}

    local t = {}
    for lang, snip in pairs(snips) do t[lang] = {parse({trig="pp", wordTrig=true}, snip)} end
    ls.add_snippets(nil, t)
end

M.nvim_tree = function()
    require('nvim-tree').setup {
        actions = { open_file = { quit_on_open = true } },
        filters = { custom = { '.git', 'node_modules', '.cache', '__pycache__' } },
        renderer = { indent_markers = { enable = true } },
    }
end

M.telescope = function()
    local telescope = require("telescope")
    telescope.setup {
        defaults = {
            prompt_prefix = "   ", selection_caret = " ",
            sorting_strategy = "ascending",
            layout_config = { prompt_position = "top" },
            file_ignore_patterns = {'__pycache__/', 'node_modules/', '%.lock', 'target/'},
        }
    }
    telescope.load_extension("projects") -- LATER: ui-select/media-files
end

function M.indent_blankline()
    require("indent_blankline").setup{
        show_current_context = true, char = "▏", -- 
        strict_tabs = true, filetype_exclude = { "help" },
    }
end

M.neorg = function()
    require('neorg').setup {
        load = {
            ["core.defaults"] = {},
            ["core.export"] = {},
            ["core.export.markdown"] = {},
            ["core.norg.completion"] = { config={ engine="nvim-cmp" } },
            ["core.norg.concealer"] = { config={ icon_preset = "diamond", dim_code_blocks={conceal=false} } },
            -- ["core.norg.concealer"] = { config={ icon_preset = "diamond" }},
            ["core.presenter"] = { config={ zen_mode = "zen-mode" } },
            ["core.execute"] = {},
            ["core.itero"] = {},
            -- ["core.bruh"] = {}
        }
    }
end

M.treesitter = function()
    require('nvim-treesitter.configs').setup {
        ensure_installed = { "norg" , "comment" },
        highlight = { enable = true },
        indent = { enable = true }, -- TODO: try text objects somewhen
    }
end

return M
