local actions = require('telescope.actions')
require('telescope').setup({
	defaults = {
		mappings = {
			n = {
				["d"] = actions.delete_buffer,
			},
		},
	},
})
