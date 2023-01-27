
-->  General stuff
require '_settings'
require '_autocmds'
require '_mappings'
require '_lazyness'

-->  UI and LSP
require '_utils'  .splash_screen()
require '_config' .tokyodark(false)
require '_lsp'    .init()
require '_lsp'    .setup_servers()
require '_nice'   .init()
