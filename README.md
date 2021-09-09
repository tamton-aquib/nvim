
# Neovim config
My neovim config

---
![nvim_ss_03](https://i.imgur.com/B1gWlPL.png)
![nvim_ss_03](https://i.imgur.com/D1yBclH.png)
---

* neovim version: 0.5
* Statusline and bufferline : [staline and stabline](https://github.com/tamton-aquib/staline.nvim)
* Colorscheme: [custom](https://github.com/tamton-aquib/nvim/blob/main/lua/custom/noice_dark.lua)
* LSP: builtin. (inside lua/lsp/)

### Structure:

```
 .
├──  init.lua
└──  lua
   ├──  custom
   │  ├──  noice_comment.lua
   │  ├──  noice_dark.lua
   │  ├──  noice_rename.lua
   │  ├──  noice_sus.lua
   │  ├──  noiceboard.lua
   │  └──  scheme_picker.lua
   ├──  general
   │  ├──  functions.lua
   │  ├──  mappings.lua
   │  ├──  packer.lua
   │  └──  settings.lua
   ├──  lsp
   │  ├──  cmp.lua
   │  ├──  emmet_lsp.lua
   │  ├──  lspconfig.lua
   │  └──  lsps.lua
   ├──  plugins
   │  ├──  floaterm.lua
   │  ├──  lir.lua
   │  ├──  neorg.lua
   │  ├──  plug-colorizer.lua
   │  ├──  snippets.lua
   │  ├──  telescope.lua
   │  ├──  treesittter.lua
   │  └──  web_devicons.lua
   └──  themes
      ├──  colorschemes.lua
      ├──  dashboard.lua
      └──  staline.lua
```

