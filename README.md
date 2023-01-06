# Neovim config
My neovim config

---
![image](https://user-images.githubusercontent.com/77913442/146633265-bdbcdae3-29b2-4058-b217-d5f2b162af40.png)
![image](https://user-images.githubusercontent.com/77913442/146633549-c098e7ca-6f6d-4740-8ab6-531d8a030555.png)
![image](https://user-images.githubusercontent.com/77913442/146633580-3fa0430e-228e-4010-97ca-46ea58cffc14.png)
---

### Summary

* neovim version : 0.9
* Colorscheme: [tokyodark.nvim](https://github.com/tiagovla/tokyodark.nvim)
* Statusline and bufferline : [staline and stabline](https://github.com/tamton-aquib/staline.nvim)
* LSP: builtin with lspconfig.
* Completion engine: [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
* optional deps: rg, lazygit

### Structure:

```
  nvim
├──  init.lua
└──   lua
   ├──  _autocmds.lua
   ├──  _mappings.lua
   ├──  _lazy.lua
   ├──  _utils.lua
   ├──  _settings.lua
   ├──  _config.lua
   └──  _lsp.lua
```
