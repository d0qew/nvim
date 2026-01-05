local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { 'phaazon/hop.nvim' },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "MunifTanjim/nui.nvim",
          "nvim-tree/nvim-web-devicons", -- optional, but recommended
        },
        lazy = false, -- neo-tree will lazily load itself
    },
    { dir = "~/Documents/pets/y9nika.nvim", name = "y9nika", priority = 1000 },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    {
	 "navarasu/onedark.nvim",
	 lazy = false,
	 priority = 1000,
	 config = function()
    	 require("onedark").setup({
      	   style = "cool", -- варианты: "dark", "darker", "cool", "deep", "warm", "warmer", "light"
					 transparent = false,
           code_style = {
             comments = "italic",
           },
					 lualine = {
              transparent = false, -- lualine center bar transparency
    			 },
           diagnostics = {
            darker = true,
            undercurl = true,
            background = true,
          },
        })
        require("onedark").load()
      end,
    },
    { 'nvim-treesitter/nvim-treesitter' },
		{
      "neovim/nvim-lspconfig",
      event = { "BufReadPre", "BufNewFile" },
      dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
      },
		},
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-cmdline' },
    { 'hrsh7th/vim-vsnip' },
    { 'mason-org/mason.nvim' },
    { 
      'nvim-telescope/telescope.nvim',
      dependencies = {
				'nvim-lua/plenary.nvim',
				'BurntSushi/ripgrep',
      },
    },
    { 'mfussenegger/nvim-lint' },
    {
      "stevearc/conform.nvim",
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        local conform = require("conform")
      end,
    },
    { 
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' }	
    },
    {
      "wojciech-kulik/xcodebuild.nvim",
      dependencies = {
        "nvim-telescope/telescope.nvim",
        "MunifTanjim/nui.nvim",
				"nvim-treesitter/nvim-treesitter",
      },
    },
    {
      "mfussenegger/nvim-dap",
      dependencies = {
        "wojciech-kulik/xcodebuild.nvim"
      },
    },
    {
      "rcarriga/nvim-dap-ui",
      dependencies = {
      	"mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",
      },
      lazy = true,
    },
    {
      "NeogitOrg/neogit",
      dependencies = {
	"nvim-lua/plenary.nvim",
    	"sindrets/diffview.nvim",
	"nvim-telescope/telescope.nvim",
      },
    },
    {
    	"ThePrimeagen/vim-be-good",
    	cmd = "VimBeGood",
    },
    {
	"j-hui/fidget.nvim",
  	event = "VeryLazy",
    },
    { 'rasulomaroff/reactive.nvim' },
    { 
	"leoluz/nvim-dap-go",
	ft = "go",
	dependencies = "mfussenegger/nvim-dap",
	config = function(_, opts)
	  require("dap-go").setup(opts)
	end
    },
    {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = true,
    },
  },
  checker = { enabled = true },
})
