
--> GENERAL SETTINGS AND MAPPINGS
require 'general.startup'
require 'general.packer'
require 'general.settings'
require 'general.autocommands'
require 'general.mappings'

--> CUSTOMS and THEMES section
require 'custom.noice_board'.setup()
require 'themes.colorschemes'.catppuccino(false)
-- require 'custom.noice_sus'.setup()
