local function setup()
	require("telescope").load_extension("aerial")

	local actions = require("telescope.actions")
	require("telescope").setup({
		defaults = {
			layout_config = { preview_width = 0.5 },
			mappings = {
				i = {
					["<esc>"] = actions.close,
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous
				}
			},
		},
		pickers = {
			buffers = {
				show_all_buffers = true,
				sort_lastused = true,
				theme = "dropdown",
				previewer = false,
				mappings = {
					i = {
						["<C-d>"] = "delete_buffer",
					}
				}
			},
			colorscheme = {
				enable_preview = true,
				layout_config = {
					horizontal = {
						preview_cutoff = 0,
					},
				}
			}
		}
	})

	local builtin = require('telescope.builtin')
	vim.keymap.set('n', '<space>fa', builtin.builtin, {})

	vim.keymap.set('n', '<space>fg', builtin.live_grep, {})

	vim.keymap.set('n', '<space>fb', builtin.buffers, {})
	vim.keymap.set('n', '<space>fm', function() builtin.marks({ mark_type = "all" }) end, {})

	-- vim.keymap.set('n', '<space>fc', builtin.colorscheme, {})

	vim.keymap.set('n', '<space>fh', builtin.help_tags, {})
	vim.keymap.set('n', '<space>fk', builtin.keymaps, {})

	vim.keymap.set('n', '<space>ft', builtin.git_files, {})
	vim.keymap.set('n', '<space>ff', builtin.find_files, {})

	vim.keymap.set('n', '<space>fc', builtin.quickfix, {})
	vim.keymap.set('n', '<space>fq', builtin.quickfixhistory, {})

	vim.keymap.set('n', '<space>fs', builtin.lsp_document_symbols, {})
	vim.keymap.set('n', '<space>fo', '<cmd>Telescope aerial<CR>', {})
	vim.keymap.set('n', '<space>fd', builtin.diagnostics, {})
end

return {
	'nvim-telescope/telescope.nvim',
	dependencies = {
		'stevearc/aerial.nvim',
		'nvim-lua/plenary.nvim',
	},
	config = setup
}
