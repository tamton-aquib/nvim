colo retrobox
echo "Setting stuff up..."

let ts_temp_path = '/tmp/ts.tmp'
call system('git clone --filter=blob:none --depth=1 https://github.com/nvim-treesitter/nvim-treesitter.git ' . ts_temp_path)
execute 'set rtp+=' . ts_temp_path

let temp_path = '/tmp/neorg.tmp'
call system('git clone --filter=blob:none --depth=1 https://github.com/nvim-neorg/neorg.git ' . temp_path)
execute 'set rtp+=' . temp_path

echo "Cloned to temp_path and added to rtp!"

lua require "nvim-treesitter.install".commands.TSInstall.run("norg")
lua require("neorg").setup { load = { ["core.defaults"] = {}, ["core.concealer"]={}, ["core.tangle"] = {}} }
