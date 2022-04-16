# Neovim config
My neovim config

---
![image](https://user-images.githubusercontent.com/77913442/146633265-bdbcdae3-29b2-4058-b217-d5f2b162af40.png)
![image](https://user-images.githubusercontent.com/77913442/146633549-c098e7ca-6f6d-4740-8ab6-531d8a030555.png)
![image](https://user-images.githubusercontent.com/77913442/146633580-3fa0430e-228e-4010-97ca-46ea58cffc14.png)
---
<!-- Previous screenshots
![image](https://user-images.githubusercontent.com/77913442/136957780-0459199a-c79d-43d2-9f13-7a9c8011cd71.png)
* Colorscheme: [custom](https://github.com/tamton-aquib/nvim/blob/main/lua/custom/noice_dark.lua)
-->

### Summary

* neovim version : 0.7
* optional deps: rg
* Colorscheme: [tokyodark.nvim](https://github.com/tiagovla/tokyodark.nvim) with [Themer](https://github.com/ThemerCorp/themer.lua)
* Statusline and bufferline : [staline and stabline](https://github.com/tamton-aquib/staline.nvim)
* LSP: builtin (config @[here](https://github.com/tamton-aquib/nvim/blob/dev/lua/lsp/lsp_defaults.lua))
* Completion engine: [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) (config @[here](https://github.com/tamton-aquib/nvim/blob/dev/lua/lsp/cmp.lua))

### Structure:

```
  nvim
├──  init.lua
└──   lua
   ├──   general
   │  ├──  autocommands.lua
   │  ├──  mappings.lua
   │  ├──  packer.lua
   │  ├──  start.lua
   │  ├──  utils.lua
   │  └──  settings.lua
   ├──   lsp
   │  ├──  cmp.lua
   │  ├──  lsp_defaults.lua
   │  └──  lsp_installer.lua
   └──   plugins
      └──  init.lua
```

