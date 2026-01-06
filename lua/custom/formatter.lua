local M = {}

-- === НАСТРОЙКИ ===
-- Включи это, чтобы видеть логи (true / false)
M.debug = false 

-- === УТИЛИТЫ ===
local function debug_log(msg)
  if not M.debug then
    return
  end
  vim.schedule(function()
    -- создаём временный буфер с логами
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(msg, "\n"))
    -- открываем его в новом окне, а не затираем текущий файл
    vim.cmd("vsplit")
    vim.api.nvim_win_set_buf(0, buf)
  end)
end

-- поиск .swiftformat вверх по дереву
local function find_config_path(filepath)
  local dir = vim.fn.fnamemodify(filepath, ":h")
  while dir ~= "/" do
    local cfg = dir .. "/.swiftformat"
    if vim.fn.filereadable(cfg) == 1 then
      return cfg
    end
    dir = vim.fn.fnamemodify(dir, ":h")
  end
  return nil
end

-- === ОСНОВНАЯ ФУНКЦИЯ ===
function M.format_buffer_sync(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  local filepath = vim.api.nvim_buf_get_name(bufnr)
  if filepath == "" then
    vim.notify("No file name", vim.log.levels.WARN)
    return
  end

  local exe = vim.fn.exepath("swiftformat")
  if exe == "" then
    vim.notify("swiftformat not found in PATH", vim.log.levels.ERROR)
    return
  end

  local cfg_path = find_config_path(filepath)
  local cfg_info
  if cfg_path and vim.fn.filereadable(cfg_path) == 1 then
    cfg_info = "✅ Config found: " .. cfg_path
  else
    cfg_info = "⚠️  No .swiftformat found, using defaults"
  end

  -- собираем команду
  local cmd = { exe, "--verbose", "--cache", "ignore" }
  if cfg_path then
    table.insert(cmd, "--config")
    table.insert(cmd, cfg_path)
  end
  table.insert(cmd, filepath)

  local cmd_str = table.concat(cmd, " ")
  local logmsg = "📄 File: " .. filepath .. "\n" .. cfg_info .. "\n\n🚀 Running:\n" .. cmd_str .. "\n"

  -- выполняем форматирование
  local result = vim.fn.systemlist(cmd)
  local exit = vim.v.shell_error

  if exit == 0 then
    -- перечитываем файл, чтобы обновить буфер
    vim.cmd("edit!")
    vim.notify("SwiftFormat OK ✅", vim.log.levels.INFO)
  else
    vim.notify("SwiftFormat failed ❌ (exit " .. exit .. ")", vim.log.levels.ERROR)
  end

  if M.debug then
    logmsg = logmsg .. "\n==== SwiftFormat Output ====\n" .. table.concat(result, "\n")
    debug_log(logmsg)
  end
end

-- === КЛАВИША ===
vim.keymap.set("n", "<leader>f", function()
  M.format_buffer_sync()
end, { noremap = true, silent = true, desc = "Format Swift file" })

-- === АВТОФОРМАТ ПРИ СОХРАНЕНИИ ===
-- local group = vim.api.nvim_create_augroup("SwiftFormatAutoSave", { clear = true })
-- vim.api.nvim_create_autocmd("BufWritePost", {
  -- pattern = "*.swift",
  -- group = group,
  -- callback = function(args)
    -- M.format_buffer_sync(args.buf)
  -- end,
-- })

-- форматируем выделенный диапазон строк (буфер, start_line, end_line)
function M.format_range(bufnr, start_line, end_line)
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  if not start_line or not end_line then
    vim.notify("No range provided", vim.log.levels.WARN)
    return
  end

  local filepath = vim.api.nvim_buf_get_name(bufnr)
  local exe = vim.fn.exepath("swiftformat")
  if exe == "" then
    vim.notify("swiftformat not found in PATH", vim.log.levels.ERROR)
    return
  end

  -- сохраняем весь буфер в temp (так безопаснее для несохранённых буферов)
  local tmp_in = vim.fn.tempname() .. ".swift"
  local tmp_out = vim.fn.tempname() .. ".swift"
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local wrote = vim.fn.writefile(lines, tmp_in)
  if wrote ~= 0 then
    vim.notify("Failed to write tmp file", vim.log.levels.ERROR)
    return
  end

  -- ищем конфиг (передаём путь к файлу если есть, иначе cwd)
  local cfg_path = find_config_path(filepath ~= "" and filepath or vim.fn.getcwd())

  -- собираем команду: swiftformat <in> --output <out> --line-range start,end [--config <cfg>]
  local cmd = { exe, tmp_in, "--output", tmp_out }
  if cfg_path then
    table.insert(cmd, "--config")
    table.insert(cmd, cfg_path)
  end
  table.insert(cmd, "--line-range")
  table.insert(cmd, tostring(start_line .. "," .. end_line))

  if M.debug then
    debug_log("Running: " .. table.concat(cmd, " "))
  end

  local result = vim.fn.systemlist(cmd)
  local exit = vim.v.shell_error

  if exit ~= 0 then
    vim.notify("SwiftFormat failed for range ❌ (exit " .. exit .. ")", vim.log.levels.ERROR)
    if M.debug then
      debug_log("SwiftFormat output:\n" .. table.concat(result, "\n"))
    end
    pcall(vim.fn.delete, tmp_in)
    pcall(vim.fn.delete, tmp_out)
    return
  end

  -- читаем отформатированный файл и берём только нужный диапазон строк
  local formatted = vim.fn.readfile(tmp_out)
  -- защита от выхода за границы (если форматтер сократил/добавил строки)
  local fstart = math.max(1, start_line)
  local fend = math.min(#formatted, end_line)
  local sel = {}
  for i = fstart, fend do
    table.insert(sel, formatted[i])
  end

  -- заменяем строки в буфере (в API нумерация 0-based: start-1 .. end)
  local ok, err = pcall(function()
    local view = vim.fn.winsaveview()
    vim.api.nvim_buf_set_lines(bufnr, start_line - 1, end_line, false, sel)
    vim.fn.winrestview(view)
  end)
  if not ok then
    vim.notify("Failed to replace buffer lines: " .. tostring(err), vim.log.levels.ERROR)
  else
    vim.notify("SwiftFormat OK for selection ✅", vim.log.levels.INFO)
  end

  -- cleanup
  pcall(vim.fn.delete, tmp_in)
  pcall(vim.fn.delete, tmp_out)
end

-- визуальная мапа: форматировать выделение (режим 'v')
vim.keymap.set("v", "<leader>f", function()
  -- '< и '> дают границы выделения даже после выхода из визуала
  local start_line = vim.fn.line("'<")
  local end_line = vim.fn.line("'>")
  -- иногда курсор может быть после конца — нормализуем
  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end
  M.format_range(nil, start_line, end_line)
end, { noremap = true, silent = true, desc = "Format visual selection (Swift)" })

return M

