local actions = require'lir.actions'
local mark_actions = require 'lir.mark.actions'
local clipboard_actions = require'lir.clipboard.actions'

require'lir'.setup {
  show_hidden_files = false,
  devicons_enable = true,
  mappings = {
    ['l']     = actions.edit,
    ['<C-s>'] = actions.split,
    ['<C-v>'] = actions.vsplit,
    ['<C-t>'] = actions.tabedit,

    ['h']     = actions.up,
    ['q']     = actions.quit,

    ['K']     = actions.mkdir,
    ['N']     = actions.newfile,
    ['R']     = actions.rename,
    ['@']     = actions.cd,
    ['Y']     = actions.yank_path,
    ['.']     = actions.toggle_show_hidden,
    ['D']     = actions.delete,

    ['J'] = function()
      mark_actions.toggle_mark()
      vim.cmd('normal! j')
    end,
    ['C'] = clipboard_actions.copy,
    ['X'] = clipboard_actions.cut,
    ['P'] = clipboard_actions.paste,
  },
  float = {
    -- If you want to configure the height and width of the window individually,
    -- pass in a table like so: { width = 0.5, height = 0.8 }
    size_percentage = 0.5,
    winblend = 15,
    border = true,
    borderchars = {"╔" , "═" , "╗" , "║" , "╝" , "═" , "╚", "║"},

    -- -- If you want to use `shadow`, set `shadow` to `true`.
    -- -- Also, if you set shadow to true, the value of `borderchars` will be ignored.
    shadow = true,
  },
  hide_cursor = false,
}
