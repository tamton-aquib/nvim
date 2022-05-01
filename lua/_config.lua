local M = {}

M.staline = function()
    -->             ⌬  | left   :           | right  :            | toggle:  
    require('stabline').setup {
        fg = "#986fec",
        bg = "#11121d"
    }

    require("staline").setup {
        sections = {
            left = { '  ', 'mode', ' ', 'branch', '  ⌬  ', 'lsp' },
            mid = { 'file_name', '%<', },
            right = { '    %l/%L  :%c    ',
                function()
                    local chars = { "_", "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
                    local line_ratio = vim.fn.line(".") / vim.fn.line("$")
                    local index = math.ceil(line_ratio * #chars)
                    return chars[index]
                end, ' '
            },
        },
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

    vim.cmd [[color tokyodark]]
    vim.cmd [[hi! link IndentBlanklineChar Comment]]
end

M.luasnip = function()
    local prints = {
        rust = [[println!("{${0}}");]],
        python = [[print(${0})]],
        javascript = [[console.log(${0});]],
        svelte = [[console.log(${0});]],
        lua = [[print(${0})]],
        c = [[printf("${0}");]],
        cpp = [[std::cout << ${0} << std::endl;]]
    }

    local ls = require('luasnip')
    local parse = ls.parser.parse_snippet

    ls.add_snippets(nil, {
        all = {
            parse({trig="#!", wordTrig=true}, "#!/usr/bin/env ${0}"),
            parse({trig="pp", wordTrig=true}, prints[vim.bo.ft] or "🍣"),
        }
    })
end

M.nvim_tree = function()
    require('nvim-tree').setup {
        actions = { open_file = { quit_on_open = true } },
        filters = { custom = { '.git', 'node_modules', '.cache', '__pycache__' } },
        renderer = { indent_markers = { enable = true } },
    }
end

M.telescope = function()
    require('telescope').setup{
        defaults = {
            prompt_prefix = "   ",
            selection_caret = " ",
            sorting_strategy = "ascending",
            layout_config = { prompt_position = "top" },
            file_ignore_patterns = {'__pycache__/', 'node_modules/'},
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
            "terminal", "dashboard", "lsp-installer",
            "packer", "TelescopePrompt", "help"
        },
    }
end

M.neorg = function()
    require('neorg').setup {
        load = {
            ["core.norg.completion"] = { config={ engine="nvim-cmp" } },
            ["core.defaults"] = {},
            ["core.norg.concealer"] = { config = { icon_preset = "diamond" } },
        }
    }
end

M.treesitter = function()
    require('nvim-treesitter.configs').setup {
        ensure_installed = { "norg" ,"lua" },
        highlight = { enable = true },
        indent = { enable = true },
    }
end

return M
