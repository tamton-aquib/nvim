vim.g.did_load_filetypes = 1
vim.g.loaded_gzip = false
vim.g.loaded_matchit = false
vim.g.loaded_netrwPlugin = false
vim.g.loaded_tarPlugin = false
vim.g.loaded_zipPlugin = false
vim.g.loaded_man = false
vim.g.loaded_2html_plugin = false
vim.g.loaded_remote_plugins = false

-- vim.cmd [[ filetype plugin indent off ]]
vim.opt.spell = false

local ok, stuff = pcall(require, 'impatient')
if ok then stuff.enable_profile() end

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
	vim.cmd 'packadd packer.nvim'
end

require("packer").init {
	profile = { enable = true },
	-- compile_path = vim.fn.stdpath('config')..'/lua/packer_compiled.lua',
	display = {
		done_sym = "✓",
		error_sym = "×",
		working_sym = "",
		open_fn = function()
			return require('packer.util').float{
				border = require"general.utils".border
			}
		end
	}
}
