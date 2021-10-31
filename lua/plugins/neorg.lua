-- vim.cmd [[packadd nvim-treesitter]]
-- vim.cmd [[packadd neorg]]
local neorg_callbacks = require('neorg.callbacks')

neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, content)
    content.map_event_to_mode("norg", {
		n = {
			{ "<C-Space>", "core.norg.qol.todo_items.todo.task_cycle" },
			{ "<C-s>", "core.integrations.telescope.find_linkable" },
		},
    }, { silent = true, noremap = true })

end)

require('neorg').setup {
    load = {
		["core.norg.completion"] = {
			config = {
				engine = "nvim-cmp"
			}
		},
		["core.defaults"] = {},
		["core.norg.concealer"] = {
			config = {
				icons = {
					heading = {
						level_1 = {
							icon = "◈",
						},
						level_2 = {
							icon = " ◇",
						},
						level_3 = {
							icon = "  ◆",
						},
						level_4 = {
							icon = "   ⋄",
						},
						level_5 = {
							icon = "    ❖",
						},
						level_6 = {
							icon = "     ⟡",
						},
					},
				},
			}
		},
		-- ["core.norg.tangle"] = {},
		["core.integrations.telescope"] = {},
		["core.integrations.treesitter"] =  {
			config = {
				dim = {}
			}
		},
		["core.norg.dirman"] = {
			config = {
				workspaces = {
					my_workspace = "~/neorg",
				},
				autodetect = true,
				autochdir = true,
			}
		}
	},
	-- logger = {
	-- level = "trace"
	-- }
}
