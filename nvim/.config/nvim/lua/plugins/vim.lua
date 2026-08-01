local set = vim.opt

set.tabstop = 2
set.softtabstop = 2
set.shiftwidth = 2
set.number = true
set.shortmess = "I"
set.scrolloff = 9
set.cursorline = true
set.termguicolors = true
set.showmode = false

local keymap = vim.keymap
keymap.set('n', 's', '<C-w>', { remap = true })
keymap.set('n', '<C-w>n', '<cmd>bn<CR>', { remap = true })
keymap.set('n', '<C-w>p', '<cmd>bp<CR>', { remap = true })
keymap.set('n', '<C-w>c', '<cmd>bp<bar>sp<bar>bn<bar>bd<CR>', { remap = true })

keymap.set('n', '<C-w>s', '<Nop>')
keymap.set('n', '<C-w>v', '<Nop>')

local function setup_win(win)
	if not vim.g.dropbar_enabled then
		vim.wo[win][0].winbar = ''
		vim.w[win].dropbar_enabled = false
	end
end

keymap.set('n', '<C-w>s', function()
	local buf = vim.api.nvim_get_current_buf()
	local win = vim.api.nvim_open_win(buf, true, { split = 'right', win = 0 })
	setup_win(win)
end)

keymap.set('n', '<C-w>v', function()
	local buf = vim.api.nvim_get_current_buf()
	local win = vim.api.nvim_open_win(buf, true, { split = 'below', win = 0 })
	setup_win(win)
end)

return {}
