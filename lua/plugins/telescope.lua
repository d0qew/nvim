return {
		{ 
				'nvim-telescope/telescope.nvim',
				dependencies = {
						'nvim-lua/plenary.nvim',
						'BurntSushi/ripgrep',
				},
				config = function()
						local builtin = require('telescope.builtin')
						local actions = require('telescope.actions')

						require('telescope').setup({
							defaults = {
								mappings = {
									i = {
										["<C-d>"] = actions.delete_buffer,
									},
									n = {
										["d"] = actions.delete_buffer,
									},
								},
							},
						})

						vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
						vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = 'Telescope live grep' })
						vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
						vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
						vim.keymap.set('n', '<leader>gb', builtin.git_branches, {})
						vim.keymap.set('n', '<leader>gc', builtin.git_commits, {})
						vim.keymap.set('n', '<leader>gs', builtin.git_status, {})
						vim.keymap.set('n', 'gr', builtin.lsp_references, {noremap = true, silent = true})
						vim.keymap.set('n', 'gd', builtin.lsp_definitions, {noremap = true, silent = true})
				end,
		},
}
