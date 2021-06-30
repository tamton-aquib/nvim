
require('neorg').setup {
    load = {
        ["core.defaults"] = {},
        ["core.norg.concealer"] = {},
        ["core.norg.dirman"] = {
            config = {
                workspaces = {
                    my_workspace = "~/neorg",
                },
                -- Automatically detect whenever we have entered a subdirectory of a workspace
            autodetect = true,
            -- Automatically change the directory to the root of the workspace every time
            autochdir = true,
            }
        }
    },
}

