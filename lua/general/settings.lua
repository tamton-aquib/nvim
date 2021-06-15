local cmd = vim.api.nvim_command
local current = vim.api.nvim_get_current_buf

cmd('set iskeyword+=-')
cmd('syntax enable')
cmd("filetype plugin indent on")
cmd('set inccommand=split')

vim.go.t_Co = "256"
vim.opt.more = false

vim.opt.mouse = "a"
vim.opt.encoding = "UTF-8"
vim.opt.fileencoding = "UTF-8"
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.hidden = true
vim.opt.scrolloff = 8
vim.opt.timeoutlen = 300
vim.opt.updatetime = 500
vim.opt.hlsearch = false
vim.opt.clipboard = "unnamedplus"
vim.opt.smarttab = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.conceallevel = 0
vim.opt.cmdheight = 1
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.pumheight = 10
vim.opt.incsearch = true
vim.opt.showmode = false
vim.opt.showtabline = 2
vim.opt.laststatus = 2
vim.opt.foldenable = false
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 25

function on_file_enter()
	vim.opt.expandtab = false
	vim.opt.copyindent = true
	vim.opt.shiftwidth = 4
	vim.opt.tabstop = 4
	vim.opt.softtabstop = 4
	vim.opt.autoindent = true
	vim.opt.smartindent = true

	if vim.fn.getpos('"') then 
		vim.cmd("norm '\"")
	end

end
vim.cmd [[ autocmd FileType * :lua on_file_enter() ]]

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.list = true
-- vim.opt.listchars = 'tab:┊ '
vim.opt.listchars = 'tab: '

vim.opt.filetype = "on"

vim.opt.formatoptions = vim.opt.formatoptions - "cro"

