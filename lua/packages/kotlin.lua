vim.env.KOTLIN_LSP_DIR = vim.fn.expand("/opt/homebrew/Cellar/kotlin-lsp/262.7569.0/libexec/")
require('kotlin').setup({
  inlay_hints = { enabled = true },
  jvm_args = { '-Xmx4g' },
})
