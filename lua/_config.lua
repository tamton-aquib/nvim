local M = {}

function Bruh(id) ({require("essentials").run_file, require("mpv").toggle_player})[id]() end
local lvar = 1
M.staline = function()
    -->              ⌬  | left   :           | right  :            | toggle:  

    vim.g.mpv_visualizer = "play"
    require('stabline').setup {
        style='slant',
        stab_end="%#Function#%1@v:lua.Bruh@   run %X     ",
        stab_start = "%#Function#    ",
    }

    require("staline").setup {
        sections = {
            left = { '  ', 'mode', ' ', 'branch', '  ⌬  ', 'lsp' },
            right = {
                function() return vim.b.bookmark or '' end,
                '%2@v:lua.Bruh@  %{g:mpv_visualizer} %X    ',
                function()
                    local chars = { "∙∙∙", "●∙∙", "∙●∙", "∙∙●", "∙∙∙" }
                    local p = vim.lsp.util.get_progress_messages()[1]
                    if not p then return '' end

                    lvar = (lvar + 1) % #chars
                    return ("%#Function#" .. chars[lvar+1]) or ""
                end,
                '    %l/%L  :%c    ',
                { 'Staline', function()
                    local chars = { "_", "▁", "▂", "▃", "▄", "▅", "▆", "▇", "█" }
                    local line_ratio = vim.fn.line(".") / vim.api.nvim_buf_line_count(0)
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
        special_table = { lazy = { 'Lazy', '💤' } } -- not working for some reason
    }
end

M.devicons = function()
    require("nvim-web-devicons").setup { override={
        norg={icon="", color="#4878BE", name="neorg"},
        rs={icon="🦀", name="Rss"}
    }}
end

M.tokyodark = function(t)
    vim.g.tokyodark_transparent_background = t and true or false
    vim.g.tokyodark_enable_italic = false
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
            sorting_strategy = "ascending", layout_config = { prompt_position = "top" },
            file_ignore_patterns = {'__pycache__/', 'node_modules/', '%.lock', 'target/', '__pypackages__/'},
        }
    }
end

M.neorg = function()
    require('neorg').setup {
        load = {
            ["core.defaults"] = {},
            ["core.export"] = {},
            ["core.export.markdown"] = {},
            ["core.norg.completion"] = { config={ engine="nvim-cmp" } },
            ["core.norg.concealer"] = { config={ dim_code_blocks={conceal=false} } },
            ["core.presenter"] = { config={ zen_mode = "zen-mode" } },
            -- ["core.execute"] = {}, ["core.jupyter"] = {},
            ["core.itero"] = {},
        }
    }
end

M.treesitter = function()
    require('nvim-treesitter.configs').setup {
        ensure_installed = { "comment", "lua", "python" },
        highlight = { enable = true },
        indent = { enable = true }, -- TODO: try text objects somewhen
    }
end

return M
