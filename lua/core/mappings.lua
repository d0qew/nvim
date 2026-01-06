-- Commons 
vim.g.mapleader = " "
vim.keymap.set("i", "jj", "<ESC>", { silent = true })

-- Moves
vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })
vim.keymap.set('n', 'n', 'nzzzv', { noremap = true, silent = true })
vim.keymap.set('n', 'N', 'Nzzzv', { noremap = true, silent = true })

-- Tabs 
vim.keymap.set('n', '<Tab>', 'gt', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Tab>', 'gT', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { noremap = true, silent = true })

-- Splits
vim.keymap.set('n', '|', ':vsplit<CR>')
vim.keymap.set('n', '\\', ':split<CR>')
vim.keymap.set('n', '<leader>hh', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ll', '<C-w>l', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>jj', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>kk', '<C-w>k', { noremap = true, silent = true })

-- Scaling
vim.keymap.set({"n", "i"}, "<C-=>", function()
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1
end, {desc = "Zoom in"})

vim.keymap.set({"n", "i"}, "<C-->", function()
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1
end, {desc = "Zoom out"})

-- NeoTree
vim.keymap.set('n', '<leader>e', ':Neotree float<CR>')
vim.keymap.set('n', '<leader>E', ':Neotree left toggle<CR>')
vim.keymap.set('n', '<leader>ee', ':Neotree reveal<CR>')

-- Neogit
vim.keymap.set('n', '<leader>gg', ':Neogit kind=floating<CR>')

-- Xcodebuild
vim.keymap.set("n", "<leader>xl", "<cmd>XcodebuildToggleLogs<cr>", { desc = "Toggle Xcodebuild Logs" })
vim.keymap.set("n", "<leader>xb", "<cmd>XcodebuildBuild<cr>", { desc = "Build Project" })
vim.keymap.set("n", "<leader>xr", "<cmd>XcodebuildBuildRun<cr>", { desc = "Build & Run Project" })
vim.keymap.set("n", "<leader>xt", "<cmd>XcodebuildTest<cr>", { desc = "Run Tests" })
vim.keymap.set("n", "<leader>xT", "<cmd>XcodebuildTestClass<cr>", { desc = "Run This Test Class" })
vim.keymap.set("n", "<leader>X", "<cmd>XcodebuildPicker<cr>", { desc = "Show All Xcodebuild Actions" })
vim.keymap.set("n", "<leader>xd", "<cmd>XcodebuildSelectDevice<cr>", { desc = "Select Device" })
vim.keymap.set("n", "<leader>xp", "<cmd>XcodebuildSelectTestPlan<cr>", { desc = "Select Test Plan" })
vim.keymap.set("n", "<leader>xc", "<cmd>XcodebuildToggleCodeCoverage<cr>", { desc = "Toggle Code Coverage" })
vim.keymap.set("n", "<leader>xC", "<cmd>XcodebuildShowCodeCoverageReport<cr>", { desc = "Show Code Coverage Report" })
vim.keymap.set("n", "<leader>xq", "<cmd>Telescope quickfix<cr>", { desc = "Show QuickFix List" })

-- Specific: disable updating register for x and c
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "c", '"_c')
vim.keymap.set("n", "C", '"_C')
