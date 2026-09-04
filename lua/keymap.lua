-- Common
vim.keymap.set('i', 'jj', '<ESC>', { silent = true })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true, silent = true })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })
vim.keymap.set('n', 'n', 'nzzzv', { noremap = true, silent = true })
vim.keymap.set('n', 'N', 'Nzzzv', { noremap = true, silent = true })
vim.keymap.set('n', '<C-t>', '<cmd>tabnew<CR>', { desc = 'New tab', silent = true })
vim.keymap.set('n', '<C-n>', '<cmd>tabn<CR>', { desc = 'Next tab', silent = true })
vim.keymap.set('n', '<C-b>', '<cmd>tabp<CR>', { desc = 'Previous tab', silent = true })
for i = 1, 9 do
  vim.keymap.set('n', '<leader>' .. i, '<cmd>tabn ' .. i .. '<CR>', { desc = 'Go to tab ' .. i })
end

-- Diagnostic
vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Diagnostics float' })

-- Oil
vim.keymap.set('n', '<leader>e', '<cmd>Oil<cr>', { desc = 'Open parent directory' })

-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>tf', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>tg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>tb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>tr', ':Telescope resume<CR>')
vim.keymap.set('n', 'gd', builtin.lsp_definitions, { noremap = true, desc = 'Telescope go to definition'})

-- Neogit
vim.keymap.set('n', '<leader>gg', ':Neogit<CR>')

-- Floaterminal
vim.keymap.set({ 'n', 't' }, '<leader>tt', '<cmd>Floaterminal<cr>', { desc = 'Float terminal toggle' })
vim.keymap.set('t', '<esc><esc>', '<c-\\><c-n>', { desc = 'Float terminal normal mode' })

-- FFF
vim.keymap.set('n', '<leader>ff', function() require('fff').find_files() end, { desc = 'Find files' })
vim.keymap.set('n', '<leader>fg', function() require('fff').live_grep() end, { desc = 'Grep' })

-- Xcodebuild
vim.keymap.set('n', '<leader>xa', '<cmd>XcodebuildPicker<CR>', { desc = 'Xcode actions' })
vim.keymap.set('n', '<leader>xb', '<cmd>XcodebuildBuild<CR>', { desc = 'Build' })
vim.keymap.set('n', '<leader>xr', '<cmd>XcodebuildBuildRun<CR>', { desc = 'Build & Run' })
vim.keymap.set('n', '<leader>xtb', '<cmd>XcodebuildBuildForTesting<CR>', { desc = 'Run Tests' })
vim.keymap.set('n', '<leader>xtt', '<cmd>XcodebuildTest<CR>', { desc = 'Run Tests' })
vim.keymap.set('n', '<leader>xtf', '<cmd>XcodebuildTestClass<CR>', { desc = 'Test File/Class' })
vim.keymap.set('n', '<leader>xl', '<cmd>XcodebuildToggleLogs<CR>', { desc = 'Xcode opene logs' })

-- Diffview
vim.keymap.set('n', '<leader>gh', '<cmd>DiffviewFileHistory %<CR>')
