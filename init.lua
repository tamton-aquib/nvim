
--> GENERAL SETTINGS AND MAPPINGS
require 'general.startup'
require 'general.settings'
require 'general.packer'
require 'general.autocommands'
require 'general.mappings'

--> CUSTOMS and THEMES section
require 'custom.noice_board'.setup()
require 'ui.colorschemes'.noice(true)
-- require 'custom.noice_sus'.setup()
