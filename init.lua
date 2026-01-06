-- Basic
require('core.mappings')
require('core.plugins')
require('custom.floaterminal')
require('custom.formatter')

-- Common
vim.cmd.colorscheme("catppuccin")
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.guifont = "JetBrains Mono NL"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes:1"
vim.opt.completeopt = "menu,menuone,fuzzy,noinsert"
vim.opt.swapfile = false
vim.opt.exrc = true
vim.opt.wildoptions:append { 'fuzzy' }
vim.g.format_on_save = true
vim.opt.cursorline = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.o.colorcolumn = "120"
vim.o.wrap = false
vim.g.editorconfig = false

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Neovide
if vim.g.neovide then
  vim.g.neovide_scale_factor = 2
  vim.g.neovide_hide_mouse_when_typing = true
end
