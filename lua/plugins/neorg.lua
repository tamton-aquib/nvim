require('neorg').setup {
    load = {
		["core.norg.completion"] = { config={ engine="nvim-cmp" } },
		["core.defaults"] = {},
		["core.norg.concealer"] = { config = { icon_preset = "diamond" } },
		["core.integrations.telescope"] = {},
		["core.integrations.treesitter"] =  {
			config = { public={ configure_parsers=true }}
		},
		["core.norg.dirman"] = {
			config = {
				workspaces = { my_workspace = "~/neorg" },
			}
		}
	},
	-- logger = { level = "info" }
}
