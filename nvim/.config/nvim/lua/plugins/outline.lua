vim.keymap.set('n', '<space>o<esc>', '<Nop>')

return {
	{
		'stevearc/aerial.nvim',
		config = function()
			vim.keymap.set('n', '<space>ow', '<cmd>AerialToggle<CR>')

			require("aerial").setup({
				autojump = true,
				layout = {
					min_width = 30,
				},
				on_attach = function(bufnr)
					vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
					vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
				end,
				keymaps = {
					["?"] = "actions.show_help",
					["g?"] = "actions.show_help",
					["<CR>"] = "actions.jump",
					["<2-LeftMouse>"] = "actions.jump",
					["<C-v>"] = "actions.jump_vsplit",
					["<C-s>"] = "actions.jump_split",
					["p"] = "actions.scroll",
					["<C-j>"] = "actions.down_and_scroll",
					["<C-k>"] = "actions.up_and_scroll",
					["{"] = "actions.prev",
					["}"] = "actions.next",
					["[["] = "actions.prev_up",
					["]]"] = "actions.next_up",
					["q"] = "actions.close",
					["o"] = "actions.tree_toggle",
					["za"] = "actions.tree_toggle",
					["O"] = "actions.tree_toggle_recursive",
					["zA"] = "actions.tree_toggle_recursive",
					["l"] = "actions.tree_open",
					["zo"] = "actions.tree_open",
					["L"] = "actions.tree_open_recursive",
					["zO"] = "actions.tree_open_recursive",
					["h"] = "actions.tree_close",
					["zc"] = "actions.tree_close",
					["H"] = "actions.tree_close_recursive",
					["zC"] = "actions.tree_close_recursive",
					["zr"] = "actions.tree_increase_fold_level",
					["zR"] = "actions.tree_open_all",
					["zm"] = "actions.tree_decrease_fold_level",
					["zM"] = "actions.tree_close_all",
					["zx"] = "actions.tree_sync_folds",
					["zX"] = "actions.tree_sync_folds",
				},
			})
		end
	},
	{
		'Bekaboo/dropbar.nvim',
		dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make'
    },
		config = function()
			vim.g.dropbar_enabled = false

			local api = require('dropbar.api')
			local config = require('dropbar.configs')
			local utils = require('dropbar.utils')

			local original_enable = config.opts.bar.enable
			require('dropbar').setup({
				bar = {
					enable = function (buf, win, _)
						if not vim.g.dropbar_enabled then return false end
						return original_enable(buf, win)
					end
				},
				menu = {
					keymaps = {
						['f'] = function()
							local menu = utils.menu.get_current()
							if not menu then return end
							menu:fuzzy_find_open()
						end,
					}
				}
			})

			local function toggle_dropbar()
				local win = vim.api.nvim_get_current_win()
				vim.w[win].dropbar_enabled = not vim.w[win].dropbar_enabled

				local winbar
        if vim.w[win].dropbar_enabled then winbar = '%{%v:lua.dropbar()%}'
				else winbar = '' end
				vim.wo[win][0].winbar = winbar
			end

			vim.keymap.set('n', '<space>op', function()
				local win = vim.api.nvim_get_current_win()
        if not vim.w[win].dropbar_enabled then toggle_dropbar() end
				vim.defer_fn(api.pick, 0)
			end)
			vim.keymap.set('n', '<space>oo', toggle_dropbar)
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				enable = false,
				multiwindow = false
			})
			
			vim.keymap.set('n', '<space>oc', '<cmd>TSContext toggle<CR>')
		end
	}
}
