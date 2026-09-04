local actions = require('telescope.actions')
require('telescope').setup({
	defaults = {
		preview = false,
		mappings = {
			n = {
				["d"] = actions.delete_buffer,
			},
		},
	},
})
require("telescope").load_extension("fzf")
