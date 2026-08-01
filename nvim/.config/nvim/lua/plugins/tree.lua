local function setup()
	local gwidth = vim.api.nvim_list_uis()[1].width
	local gheight = vim.api.nvim_list_uis()[1].height
	local width = math.floor(gwidth * 0.8)
	local height = math.floor(gheight * 0.8)

	vim.keymap.set('n', '<C-b>', '<cmd>NvimTreeToggle<CR>')
	vim.keymap.set('n', 'tt', '<cmd>NvimTreeToggle<CR>')
	require("nvim-tree").setup({
		view = {
			width = width,
			float = {
				enable = true,
				open_win_config = {
					relative = "editor",
					width = width,
					height = height,
					row = (gheight - height) * 0.4,
					col = (gwidth - width) * 0.5,
				}
			}
		},
		sort = {
			sorter = "case_sensitive",
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

			api.map.on_attach.default(bufnr)
			vim.keymap.set("n", "<C-t>", api.tree.change_root_to_parent, opts("Up"))
			vim.keymap.set("n", "?",     api.tree.toggle_help,           opts("Help"))
		end
	})
end

return {
	"nvim-tree/nvim-tree.lua",
	config = setup
}
