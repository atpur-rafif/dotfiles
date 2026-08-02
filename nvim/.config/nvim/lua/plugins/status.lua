local function setup()
	vim.keymap.set('n', '<leader>bj', function()
		local cmd = 'LualineBuffersJump! ' .. vim.v.count
		vim.cmd(cmd)
	end);

	vim.keymap.set('n', '<leader>bn', '<cmd>bn<CR>')
	vim.keymap.set('n', '<leader>bp', '<cmd>bp<CR>')
	vim.keymap.set('n', '<leader>br', '<cmd>e#<CR>')

	vim.keymap.set('n', '<leader>bc', '<cmd>bp<bar>sp<bar>bn<bar>bd<CR>')
	vim.keymap.set('n', '<leader>be', '<cmd>%bd<CR>')
	vim.keymap.set('n', '<leader>bo', '<cmd>%bd|e#<CR>')

	local bufferline = require("bufferline")
	bufferline.setup({
		highlights = {
			tab_selected = { bg = "#000000" },
			hint_selected = { bg = "#000000" },
			info_selected = { bg = "#000000" },
			pick_selected = { bg = "#000000" },
			error_selected = { bg = "#000000" },
			buffer_selected = { bg = "#000000" },
			warning_selected = { bg = "#000000" },
			numbers_selected = { bg = "#000000" },
			diagnostic_selected = { bg = "#000000" },
			modified_selected = { bg = "#000000" },
			duplicate_selected = { bg = "#000000" },
			-- info_diagnostic_selected = { bg = "#000000" },
			-- error_diagnostic_selected = { bg = "#000000" },
			-- warning_diagnostic_selected = { bg = "#000000" },
		},
		options = {
			custom_filter = function(buf_number, _)
				if vim.bo[buf_number].filetype == "qf" then return false end
				return true
			end,
			style_preset = {
				bufferline.style_preset.no_bold,
				bufferline.style_preset.no_italic,
				bufferline.style_preset.minimal
			},
			indicator = { style = 'none' },
			separator_style = { "", "" },
			show_buffer_close_icons = false,
			show_close_icon = false,
			diagnostics = "nvim_lsp",
			hover = {
				enabled = false
			},
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer",
					text_align = "center",
					separator = true
				}
			}
		}
	})
	vim.api.nvim_create_autocmd("BufEnter", {
		callback = function()
			local bufnr = vim.api.nvim_get_current_buf()
			local bufname = vim.api.nvim_buf_get_name(bufnr)
			local buftype = vim.bo[bufnr].buftype

			if bufname == "" and buftype == "" and vim.api.nvim_buf_line_count(bufnr) == 1 and vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] == "" then
				vim.bo[bufnr].bufhidden = "wipe"
			end
		end,
	})

	require("lualine").setup({
		options = {
			icons_enabled = true,
			theme = 'auto',
			-- component_separators = { left = '', right = '' },
			component_separators = { left = '|', right = '' },
			section_separators = { left = '', right = '' },
			disabled_filetypes = {
				statusline = {},
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			globalstatus = true,
			refresh = {
				statusline = 1000,
				tabline = 1000,
				winbar = 1000,
			}
		},
		sections = {
			lualine_a = { 'mode' },
			lualine_b = { 'branch', 'diff', 'diagnostics' },
			lualine_c = {
				"filename"
				-- {
				-- "buffers",
				-- 		show_filename_only = true,
				-- 		hide_filename_extension = false,
				-- 		show_modified_status = true,
				-- 		-- 0: Shows buffer name
				-- 		-- 1: Shows buffer index
				-- 		-- 2: Shows buffer name + buffer index
				-- 		-- 3: Shows buffer number
				-- 		-- 4: Shows buffer name + buffer number
				-- 		mode = 2,
				-- 		max_length = vim.o.columns * 2 / 3,
				-- 		symbols = {
				-- 			modified = ' ●',
				-- 			alternate_file = '',
				-- 			directory = '',
				-- 		},
				-- }
			},
			lualine_x = { 'encoding', 'filetype' },
			lualine_y = { 'progress' },
			lualine_z = { 'location' }
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = { 'filename' },
			lualine_x = { 'location' },
			lualine_y = {},
			lualine_z = {}
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {}
	})
end

return {
	'nvim-lualine/lualine.nvim',
	dependencies = {
		'akinsho/bufferline.nvim',
		'nvim-tree/nvim-web-devicons'
	},
	config = setup
}
