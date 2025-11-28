vim.g.mapleader = " "

-- NeoTree
vim.keymap.set('n', '<leader>e', ':Neotree float<CR>')
vim.keymap.set('n', '<leader>E', ':Neotree left toggle<CR>')
vim.keymap.set('n', '<leader>ee', ':Neotree reveal<CR>')

-- Neogit
vim.keymap.set('n', '<leader>gg', ':Neogit kind=floating<CR>')

-- Splits
vim.keymap.set('n', '|', ':vsplit<CR>')
vim.keymap.set('n', '\\', ':split<CR>')
vim.keymap.set('n', '<leader>hh', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ll', '<C-w>l', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>jj', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>kk', '<C-w>k', { noremap = true, silent = true })

-- Tabs 
vim.keymap.set('n', '<Tab>', 'gt', { noremap = true, silent = true })
vim.keymap.set('n', '<S-Tab>', 'gT', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>tn', ':tabnew<CR>', { noremap = true, silent = true, desc = 'New tab' })
vim.keymap.set('n', '<leader>tc', ':tabclose<CR>', { noremap = true, silent = true, desc = 'Close tab' })

-- disable updating register for x and c
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "c", '"_c')
vim.keymap.set("n", "C", '"_C')

-- commons 
vim.keymap.set("i", "jj", "<ESC>", { silent = true })

vim.keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true, silent = true })
vim.keymap.set('n', 'n', 'nzzzv', { noremap = true, silent = true })
vim.keymap.set('n', 'N', 'Nzzzv', { noremap = true, silent = true })


vim.keymap.set({"n", "i"}, "<C-=>", function()
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1
end, {desc = "Zoom in"})

vim.keymap.set({"n", "i"}, "<C-->", function()
  vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1
end, {desc = "Zoom out"})
