vim.g.did_load_filetypes = 1
vim.g.loaded_gzip = false
vim.g.loaded_matchit = false
vim.g.loaded_netrwPlugin = false
vim.g.loaded_tarPlugin = false
vim.g.loaded_zipPlugin = false
vim.g.loaded_man = false
vim.g.loaded_2html_plugin = false
vim.g.loaded_remote_plugins = false

vim.opt.spell = false

local ok, impatient = pcall(require, 'impatient')
if ok then impatient.enable_profile() end

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
	vim.cmd 'packadd packer.nvim'
end

require("packer").init {
	profile = { enable = true },
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
