--> GENERAL SETTINGS AND MAPPINGS
require 'general.startup'
require 'general.packer'
require 'general.settings'
require 'general.autocommands'
require 'general.functions'
require 'general.mappings'

--> THEMES and CUSTOM
require 'custom.noice_rename'.setup()
require 'custom.noice_board'.setup()
require 'custom.noice_sus'.setup()
require 'custom.noice_comment'.setup()
require 'custom.noice_fold'.setup()
require 'plugins.others'.femboyf()
require 'themes.colorschemes'.noice(true)
