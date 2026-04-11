-- Common
vim.keymap.set("i", "jj", "<ESC>", { silent = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })
vim.keymap.set('n', 'n', 'nzzzv', { noremap = true, silent = true })
vim.keymap.set('n', 'N', 'Nzzzv', { noremap = true, silent = true })

-- Diagnostic
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Diagnostics float' })

-- Oil
vim.keymap.set('n', '<leader>e', '<cmd>Oil<cr>', { desc = 'Open parent directory' })

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set("n", "<leader>fr", ":Telescope resume<CR>")
vim.keymap.set('n', 'gd', builtin.lsp_definitions, { noremap = true, desc = 'Telescope go to definition'})

-- Neogit
vim.keymap.set('n', '<leader>gg', ':Neogit kind=floating<CR>')

-- Floaterminal
vim.keymap.set({ 'n', 't' }, '<leader>t', '<cmd>Floaterminal<cr>', { desc = 'Float terminal toggle' })
vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>', { desc = 'Float terminal normal mode' })
