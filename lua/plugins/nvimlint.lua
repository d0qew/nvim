local lint = require("lint")

-- Привязываем swift -> swiftlint (nvim-lint уже содержит реализацию swiftlint)
lint.linters_by_ft = {
  swift = { "swiftlint" },
}

-- Автолинт: при сохранении файла запускаем try_lint()
vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "InsertLeave" }, {
  pattern = "*.swift",
  callback = function()
    -- опционально: сменить локальный cwd в корень проекта
    local root = vim.fs.find({'Package.swift', '.git'}, { upward = true, path = vim.api.nvim_buf_get_name(0) })[1]
    if root then
      local project_root = vim.fn.fnamemodify(root, ':h')
      local old = vim.fn.getcwd()
      vim.cmd("lcd " .. project_root)
      require("lint").try_lint()
      vim.cmd("lcd " .. old)
    else
      require("lint").try_lint()
    end
  end,
  group = vim.api.nvim_create_augroup("SwiftLintAuto", { clear = true }),
})

-- ручная команда
vim.api.nvim_create_user_command("SwiftLint", function() require("lint").try_lint() end, {})

