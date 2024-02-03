local set = vim.opt

set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.number = true
set.shortmess = "I"
set.scrolloff = 9
set.cursorline = true
set.termguicolors = true

local keymap = vim.keymap
keymap.set('n', 's', '<C-w>', { remap = true })

return {}
