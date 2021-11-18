# Neovim config
My neovim config

---
![image](https://user-images.githubusercontent.com/77913442/136957780-0459199a-c79d-43d2-9f13-7a9c8011cd71.png)

* Colorscheme: [custom](https://github.com/tamton-aquib/nvim/blob/main/lua/custom/noice_dark.lua)
---

### Overall Structure
* neovim version: 0.5
* Statusline and bufferline : [staline and stabline](https://github.com/tamton-aquib/staline.nvim)
* LSP: builtin. (inside lua/lsp/)
* Completion engine: nvim-cmp

### Structure:

```
  nvim
├──  init.lua
└──   lua
   ├──   general
   │  ├──  autocommands.lua
   │  ├──  mappings.lua
   │  ├──  packer.lua
   │  ├──  startup.lua
   │  ├──  utils.lua
   │  └──  settings.lua
   ├──   lsp
   │  ├──  cmp.lua
   │  └──  lsp_defaults.lua
   ├──   plugins
   │  ├──  floaterm.lua
   │  ├──  nvim_tree.lua
   │  ├──  neorg.lua
   │  ├──  snippets.lua
   │  ├──  telescope.lua
   │  └──  treesittter.lua
   └──   ui
      ├──  colorschemes.lua
      ├──  startup-config.lua
      └──  staline.lua
```

