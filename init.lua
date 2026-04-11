vim.pack.add { 
    'https://github.com/y9san9/y9nika.nvim',
    'https://github.com/stevearc/oil.nvim',
    'https://github.com/nvim-treesitter/nvim-treesitter',
	'https://github.com/neovim/nvim-lspconfig',
	'https://github.com/windwp/nvim-autopairs',
	'https://github.com/nvim-telescope/telescope.nvim',
	'https://github.com/NeogitOrg/neogit',
	'https://github.com/hrsh7th/nvim-cmp',
	'https://github.com/wojciech-kulik/xcodebuild.nvim',
	'https://github.com/nvim-tree/nvim-web-devicons',
	'https://github.com/nvim-lua/plenary.nvim',
	'https://github.com/sindrets/diffview.nvim',
    'https://github.com/hrsh7th/cmp-nvim-lsp',
    'https://github.com/hrsh7th/cmp-buffer',
    'https://github.com/hrsh7th/cmp-path',
    'https://github.com/MunifTanjim/nui.nvim',
}

-- General
vim.o.guifont = "JetBrains Mono NL"
vim.o.number = true
vim.o.relativenumber = true
vim.o.colorcolumn = '80'
vim.o.textwidth = 80
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.linebreak = false
vim.o.smoothscroll = true
vim.o.signcolumn = "yes:1"
vim.o.cursorline = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.completeopt = "menu,menuone,fuzzy,noinsert,popup"
vim.o.swapfile = false
vim.o.confirm = true
vim.o.statusline = '[%n] %<%f %h%w%m%r%=%-14.(%l,%c%V%) %P'

vim.g.mapleader = " "
vim.g.editorconfig = true
vim.g.format_on_save = true

vim.cmd.colorscheme('y9nika')
vim.cmd('syntax off')

require('diagnostic')
require('packages.oil')
require('packages.autopairs')
require('packages.telescope')
require('packages.neogit')
require('packages.cmp')
require('packages.xcodebuild')
require('custom.floaterminal')
require('keymap')

vim.lsp.enable('gopls')
vim.lsp.enable('sourcekit')

-- Autocommands
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd('FileType', {
    callback = function() pcall(vim.treesitter.start) end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if not client then return end
	vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

    vim.lsp.completion.enable(true, client.id, ev.buf, {
      autotrigger = true,
    })
  end,
})

