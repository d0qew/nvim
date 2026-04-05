vim.opt_local.expandtab  = false
vim.opt_local.tabstop    = 4
vim.opt_local.shiftwidth = 4

vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt_local.foldenable = false

vim.api.nvim_create_autocmd("BufWritePre", {
  buffer = 0,
  callback = function()
    local params = vim.lsp.util.make_range_params(0, "utf-16")
    params.context = { only = { "source.organizeImports" } }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 2000)
    for _, res in pairs(result or {}) do
      for _, action in pairs(res.result or {}) do
        if action.edit then
          vim.lsp.util.apply_workspace_edit(action.edit, "utf-16")
        end
      end
    end
    vim.lsp.buf.format({ async = false, timeout_ms = 2000 })
  end,
})
