-- =========================================
-- 🚀 Modern LSP config (Neovim 0.11+)
-- =========================================

-- 🧠 Capabilities для автодополнения
local ok, cmp_lsp = pcall(require, "cmp_nvim_lsp")
local capabilities = ok and cmp_lsp.default_capabilities()
  or vim.lsp.protocol.make_client_capabilities()

-- ========================
-- ⚙️ Настройки серверов
-- ========================

vim.lsp.config("clangd", {
  cmd = { "/usr/bin/clangd", "--background-index" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  capabilities = capabilities,
})

vim.lsp.config("kotlin_language_server", {
  cmd = { "/opt/homebrew/bin/kotlin-language-server" },
  filetypes = { "kotlin" },
  root_dir = vim.fs.root(0, { "settings.gradle", "build.gradle", "build.gradle.kts", ".git" }),
  capabilities = capabilities,
})

vim.lsp.config("sourcekit", {
  cmd = { "/usr/bin/sourcekit-lsp" },
  filetypes = { "swift" },
  root_dir = vim.fs.root(0, { "Package.swift", ".git" }),
  capabilities = capabilities,
})

vim.lsp.config("gopls", {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = vim.fs.root(0, { "go.work", "go.mod", ".git" }),
  capabilities = capabilities,
  settings = {
    gopls = {
      usePlaceholders = true,
      completeUnimported = true,
			gofumpt = true,
      analyses = {
        unusedparams = true,
        unreachable = true,
      },
    },
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.server_capabilities.signatureHelpProvider then
      vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = args.buf })
    end
  end,
})

-- ========================
-- 🚀 Автоактивация LSP
-- ========================
vim.lsp.enable("clangd")
vim.lsp.enable("kotlin_language_server")
vim.lsp.enable("sourcekit")
vim.lsp.enable("gopls")

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true }
    local map = vim.keymap.set

    map("n", "gd", vim.lsp.buf.definition, opts)
    map("n", "gr", vim.lsp.buf.references, opts)
    map("n", "K", vim.lsp.buf.hover, opts)
    map("n", "<leader>rn", vim.lsp.buf.rename, opts)
    map("n", "ca", vim.lsp.buf.code_action, opts)
    map("n", "[d", vim.diagnostic.goto_prev, opts)
    map("n", "]d", vim.diagnostic.goto_next, opts)
    map("n", "``", vim.diagnostic.open_float, opts)
    map("n", "<leader>q", vim.diagnostic.setloclist, opts)
  end,
})

-- ========================
-- 🌈 Цвета и диагностика
-- ========================
vim.diagnostic.config({
  virtual_text = true,
  underline = true,
  signs = true,
  update_in_insert = false,
  severity_sort = true,
})

vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#E06C75" })
vim.api.nvim_set_hl(0, "DiagnosticWarn",  { fg = "#E5C07B" })
vim.api.nvim_set_hl(0, "DiagnosticInfo",  { fg = "#61AFEF" })
vim.api.nvim_set_hl(0, "DiagnosticHint",  { fg = "#56B6C2" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#E06C75" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn",  { undercurl = true, sp = "#E5C07B" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo",  { undercurl = true, sp = "#61AFEF" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint",  { undercurl = true, sp = "#56B6C2" })


local augroup = vim.api.nvim_create_augroup("GoFormat", {})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  group = augroup,
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
