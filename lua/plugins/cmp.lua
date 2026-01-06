return {
		{
				'hrsh7th/nvim-cmp',
				config = function()
						local cmp = require("cmp")
						cmp.setup({
								snippet = {
										expand = function(args)
												vim.fn["vsnip#anonymous"](args.body)
										end,
								},
								window = {
										completion = cmp.config.window.bordered(),
										documentation = cmp.config.window.bordered(),
								},
								mapping = cmp.mapping.preset.insert({
										['<C-b>'] = cmp.mapping.scroll_docs(-4),
										['<C-f>'] = cmp.mapping.scroll_docs(4),
										['<C-Space>'] = cmp.mapping.complete(),
										['<C-e>'] = cmp.mapping.abort(),
										['<CR>'] = cmp.mapping.confirm({ select = true }),
										["<Tab>"] = cmp.mapping(function(fallback)
												if cmp.visible() then
													cmp.select_next_item()
												else
													fallback()
												end
										end, { "i", "s" }),
										["<S-Tab>"] = cmp.mapping(function(fallback)
												if cmp.visible() then
													cmp.select_prev_item()
												else
													fallback()
												end
										end, { "i", "s" }),
								}),
								sources = cmp.config.sources(
										{
												{ name = 'nvim_lsp' },
												{ name = 'vsnip' },
										},
										{
												{ name = 'buffer' },
												{ name = 'nvim_lsp_signature_help' },
										}
								),
						})

						cmp.setup.filetype(
								'gitcommit', 
								{
										sources = cmp.config.sources(
												{ { name = 'cmp_git' }, },
												{ { name = 'buffer' }, }
										),
								}
						)

						-- Командная строка
						cmp.setup.cmdline(
								{'/', '?'}, 
								{
										mapping = cmp.mapping.preset.cmdline(),
										sources = { { name = 'buffer' } },
								}
						)

						cmp.setup.cmdline(
								':', 
								{
										mapping = cmp.mapping.preset.cmdline(),
										sources = cmp.config.sources(
												{ { name = 'path' } },
												{ { name = 'cmdline' } }
										),
								}
						)

						-- 🧠 capabilities для LSP
						local capabilities = require('cmp_nvim_lsp').default_capabilities()

						local cmp_autopairs = require("nvim-autopairs.completion.cmp")
						cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
				end,
		},
		{ 'hrsh7th/cmp-nvim-lsp' },
		{ 'hrsh7th/cmp-buffer' },
		{ 'hrsh7th/cmp-path' },
		{ 'hrsh7th/cmp-cmdline' },
		{ 'hrsh7th/vim-vsnip' },
}
