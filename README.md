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

### Installation
> ❗ NOTE: executing this command will delete the packer folder and nvim folder. So make sure to create a backup!
```bash
curl -sL git.io/vim_install | bash
```
> If you don't feel safe executing this command, clone the repo to $XDG_CONFIG, and do `:PackerSync` inside neovim.

### Summary

* neovim version : 0.9
* optional deps: rg, lazygit
* Colorscheme: [tokyodark.nvim](https://github.com/tiagovla/tokyodark.nvim)
* Statusline and bufferline : [staline and stabline](https://github.com/tamton-aquib/staline.nvim)
* LSP: builtin with lspconfig.
* Completion engine: [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)

### Structure:

```
  nvim
├──  init.lua
└──   lua
   ├──  _autocmds.lua
   ├──  _mappings.lua
   ├──  _packer.lua
   ├──  _utils.lua
   ├──  _settings.lua
   ├──  _conf.lua
   └──  _lsp.lua
```
