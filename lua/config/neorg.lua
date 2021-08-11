vim.cmd [[packadd nvim-treesitter]]
vim.cmd [[packadd nvim-compe]]
vim.cmd [[packadd neorg]]
local neorg_callbacks = require('neorg.callbacks')

neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, content)
    content.map_event_to_mode("norg", {
	n = {
	    { "<C-p>", "core.norg.qol.todo_items.todo.task_cycle" },
	    { "<C-s>", "core.integrations.telescope.find_linkable" }
	},
    }, { silent = true, noremap = true })

end)

require('neorg').setup {
    load = {
	["core.defaults"] = {},
	["core.norg.concealer"] = {},
	["core.norg.tangle"] = {},
	["core.integrations.telescope"] = {},
	-- 		["core.integrations.treesitter"] =  {
	-- 			config = {
	-- 				dim = {}
	-- 			}
	-- 		},
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
    -- 	logger = {
    -- 		level = "trace"
    -- 	}
}

