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
		["core.norg.completion"] = { config={ engine="nvim-cmp" } },
		["core.defaults"] = {},
		["core.norg.concealer"] = { config = { icon_preset = "diamond" } },
		["core.integrations.telescope"] = {},
		["core.integrations.treesitter"] =  { config = { dim = {} } },
		["core.norg.dirman"] = {
			config = {
				workspaces = { my_workspace = "~/neorg" },
			}
		}
	},
	-- logger = { level = "info" }
}
