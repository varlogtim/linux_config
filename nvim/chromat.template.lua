-- Chromat theme
vim.opt.background = 'dark'
vim.opt.termguicolors = true

-- Clear existing highlights
vim.cmd('highlight clear')

-- Inspired by Solarized theme
local colors = {
    base03  = '#000000', -- background (dark)
    base02  = '#3c3c3c', -- background highlights
    base01  = '#5f5f5f', -- comments / secondary content
    base00  = '#757575', -- body text / default
    base0   = '#898989', -- body text / default (light)
    base1   = '#93a1a1', -- light comments / secondary
    -- base2   = '#eee8d5', -- background highlights (light)
    base2   = '#a9b1b1', -- background highlights (light)
    base3   = '#fdf6e3', -- background (light)
    yellow  = '#b58900',
    orange  = '#cb4b16',
    red     = '#dc322f',
    magenta = '#d33682',
    violet  = '#6c71c4',
    blue    = '#268bd2',
    cyan    = '#2aa198',
    green   = '#5f8700', -- bright green
}

-- :highlight command shows all things.

-- Set core highlight groups
vim.api.nvim_set_hl(0, 'Normal', { fg = colors.base1, bg = colors.base03 })
vim.api.nvim_set_hl(0, 'Comment', { fg = colors.base00, italic = true })
vim.api.nvim_set_hl(0, 'Constant', { fg = colors.cyan })
vim.api.nvim_set_hl(0, 'String', { fg = colors.cyan })
vim.api.nvim_set_hl(0, 'Number', { fg = colors.cyan })
vim.api.nvim_set_hl(0, 'Identifier', { fg = colors.base0 })
vim.api.nvim_set_hl(0, 'Function', { fg = colors.blue })
vim.api.nvim_set_hl(0, 'Statement', { fg = colors.green })
vim.api.nvim_set_hl(0, 'Operator', { fg = colors.base1 })
vim.api.nvim_set_hl(0, 'Keyword', { fg = colors.green })
vim.api.nvim_set_hl(0, 'PreProc', { fg = colors.orange })
vim.api.nvim_set_hl(0, 'Type', { fg = colors.yellow, italic = true })
vim.api.nvim_set_hl(0, 'Special', { fg = colors.blue }) -- This is self and __init__ in Pyhton.
vim.api.nvim_set_hl(0, 'Error', { fg = colors.red, bg = colors.base02 })
vim.api.nvim_set_hl(0, 'Todo', { fg = colors.magenta, bg = colors.base02, bold = true })
vim.api.nvim_set_hl(0, 'LineNr', { fg = colors.base00, bg = colors.base02 })
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = colors.base1, bg = colors.base02 })
vim.api.nvim_set_hl(0, 'SignColumn', { bg = colors.base03 })
vim.api.nvim_set_hl(0, 'StatusLine', { fg = colors.base1, bg = colors.base02 })
vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = colors.base00, bg = colors.base02 })
vim.api.nvim_set_hl(0, 'VertSplit', { fg = colors.base00, bg = colors.base03 })
vim.api.nvim_set_hl(0, 'Pmenu', { fg = colors.base0, bg = colors.base02 })
vim.api.nvim_set_hl(0, 'PmenuSel', { fg = colors.base00, bg = colors.base2 })

-- Extended highlight groups:
vim.api.nvim_set_hl(0, 'Delimiter', { fg = colors.yellow })

-- Basic Treesitter highlights
vim.api.nvim_set_hl(0, '@variable', { fg = colors.base2 })
vim.api.nvim_set_hl(0, '@function', { fg = colors.blue })
vim.api.nvim_set_hl(0, '@keyword', { fg = colors.green })
vim.api.nvim_set_hl(0, '@string', { fg = colors.cyan })
vim.api.nvim_set_hl(0, '@number', { fg = colors.cyan })
vim.api.nvim_set_hl(0, '@comment', { fg = colors.base01, italic = true })
-- Python, str, int, etc.
vim.api.nvim_set_hl(0, '@type', { fg = colors.base1, italic = true })
vim.api.nvim_set_hl(0, '@type.builtin', { fg = colors.base1, italic = true })
vim.api.nvim_set_hl(0, '@constant.builtin', { fg = colors.base1, italic = true })
vim.api.nvim_set_hl(0, '@variable.parameter', { fg = colors.base1, italic = true })
-- Python doc strings
vim.api.nvim_set_hl(0, '@string.documentation', { fg = colors.base01, italic = true })

-- LSP Generics
vim.api.nvim_set_hl(0, 'Tag', { fg = colors.base1, italic = true })

