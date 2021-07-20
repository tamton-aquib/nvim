-- File containing keybinds for Neorg

-- This sets the leader for all neorg keybinds. It is separate from the regular <Leader>,
-- And allows you to shove every neorg keybind under one "umbrella".

local neorg_callbacks = require('neorg.callbacks')

-- NEORG KEYBINDS

neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, content)

	-- Keys for managing TODO items and setting their states
	content.map_event_to_mode("norg", {
		n = {
			{ "<C-p>", "core.norg.qol.todo_items.todo.task_cycle" }
		},
	}, { silent = true, noremap = true })

end)

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

