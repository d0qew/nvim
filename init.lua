-- Basic
require('core.plugins')
require('core.mappings')

-- Plugins 
require('plugins.neotree')
require('plugins.treesitter')
require('plugins.lsp')
require('plugins.cmp') 
require('plugins.mason') 
require('plugins.telescope')
require('plugins.nvimlint')
require('plugins.formatter')
require('plugins.lualine')
require('plugins.xcodebuild')
require('plugins.xcbeautify')
require('plugins.nvimdap')
require('plugins.nvimdapui')
require('plugins.floaterminal')
require('plugins.neogit')
require('plugins.fidget')
require('plugins.catppuccin')
require('plugins.reactive')

-- Color & Themes & Font
vim.cmd.colorscheme("catppuccin")
vim.g.mapleader = ","
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
vim.opt.cursorline = true -- highlight the current cursor line
vim.opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
vim.opt.shiftwidth = 2 -- 2 spaces for indent width
vim.o.colorcolumn = "120"
vim.o.wrap = false
vim.g.editorconfig = false

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

if vim.g.neovide then
  vim.g.neovide_scale_factor = 2
  vim.g.neovide_hide_mouse_when_typing = true

  vim.g.neovide_window_blurred = true
  vim.g.neovide_opacithy = 0.80
  vim.g.neovide_normal_opacity = 0.80
  vim.g.neovide_floating_shadow = false
  vim.g.neovide_show_border = true
end
