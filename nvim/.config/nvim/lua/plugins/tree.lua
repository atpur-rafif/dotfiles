local function setup()
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1
	vim.g.nvim_tree_auto_close = 1
	vim.opt.termguicolors = true

	vim.keymap.set('n', '<C-b>', '<cmd>NvimTreeToggle<CR>')
	require("nvim-tree").setup({
		sort = {
			sorter = "case_sensitive",
		},
		view = {
			width = 30,
		},
		renderer = {
			group_empty = true,
		},
		filters = {
			dotfiles = true,
		},
		on_attach = function(bufnr)
			local api = require "nvim-tree.api"

			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			api.config.mappings.default_on_attach(bufnr)
			vim.keymap.set('n', 's', '<C-w>', opts('Select Window'))
			vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
		end
	})
end

return {
	"nvim-tree/nvim-tree.lua",
	config = setup
}
