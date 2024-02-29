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
keymap.set('n', '<C-w>n', '<cmd>bn<CR>', { remap = true })
keymap.set('n', '<C-w>p', '<cmd>bp<CR>', { remap = true })
keymap.set('n', '<C-w>c', '<cmd>bp<bar>sp<bar>bn<bar>bd<CR>', { remap = true })

return {}
