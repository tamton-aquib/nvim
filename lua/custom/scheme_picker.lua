local pickers = require"telescope.pickers"
local finders = require"telescope.finders"
local conf = require("telescope.config").values

local function scheme_picker(opts)
    pickers.new( opts, {
	prompt_title = "Nice",
	finder = finders.new_table({'tokyonight', 'noice', 'sonokai', 'onedark'}),
	sorter = conf.generic_sorter({}),

	attach_mappings = function(_, map)
	    map("i", "<CR>", function(bufnr)

		local scheme = require("telescope.actions.state").get_selected_entry()
		require 'themes.colorschemes'[scheme[1]](false)
		require("telescope.actions").close(bufnr)

	    end)
	    return true
	end

    }):find()
end

return {scheme_picker = scheme_picker}
