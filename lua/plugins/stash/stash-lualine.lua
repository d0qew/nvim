local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
  green  = '#9ece6a',
  orange = '#ff8800',
  yellow = '#ECBE7B',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white },
    x = { bg = colors.grey },
  },
  insert = {
    a = { fg = colors.black, bg = colors.blue },
    x = { bg = colors.grey },
  },
  visual = {
    a = { fg = colors.black, bg = colors.cyan },
    x = { bg = colors.grey },
  },
  replace = {
    a = { fg = colors.black, bg = colors.red },
    x = { bg = colors.grey },
  },
  command = {
    a = { fg = colors.black, bg = colors.yellow },
    x = { bg = colors.grey },
  },
  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.white },
    x = { bg = colors.black },
  },
}

local buffer_not_empty = function()
  return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
end

require('lualine').setup {
  options = {
    theme = bubbles_theme,
    component_separators = '',
    section_separators = { left = '', right = '' },
    globalstatus = true,
  },
  sections = {
    lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
    lualine_b = { 
      { 'filename', cond = buffer_not_empty },
      { 'branch' },
      { 'diff',
        symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
        diff_color = {
          added    = { fg = colors.green },
          modified = { fg = colors.orange },
          removed  = { fg = colors.red },
        },
        colored = true,
        cond = function() return vim.fn.winwidth(0) > 80 end,
      },
    },
    lualine_c = { '%=' },

    -- Правая панель: bubble для diagnostics + filetype
    lualine_x = {
      {
        'diagnostics',
        sources = { 'nvim_diagnostic' },
        sections = { 'error', 'warn' },
        symbols = { error = ' ', warn = ' ' },
        colored = true,
        diagnostics_color = {
          error = { fg = colors.red },
          warn  = { fg = colors.yellow },
        },
        update_in_insert = false,
        always_visible = true,
        cond = buffer_not_empty,
        separator = { left = '' },
        padding = { left = 1, right = 1 },
      },
      {
        'filetype',
        icon_only = false,
        colored = true,
        fg = colors.white,
        bg = colors.grey,
	separator = { left = '' },
        padding = { left = 1, right = 1 },
      },
      {
	'progress',
        colored = true,
        fg = colors.white,
        bg = colors.grey,
	separator = { left = '' },
        padding = { left = 1, right = 1 },
      },
    },

    lualine_y = {},
    lualine_z = { { 'location', separator = { right = '' }, left_padding = 2 } },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}

