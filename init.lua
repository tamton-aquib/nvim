
-->  General stuff
require '_settings'
require '_autocmds'
require '_mappings'
require '_lazyness'

-->  UI and LSP
require '_utils'  .splash_screen()
require '_config' .tokyodark(true)
require '_lsp'    .init()
require '_lsp'    .setup_servers()
require '_nice'   .init()
