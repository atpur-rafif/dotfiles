local function setup()
	require("nvim-treesitter").setup({
		highlight = {
			enable = true,
			disable = function(_, buf)
				local max_filesize = 100 * 1024 -- 100 KB
				local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
				if ok and stats and stats.size > max_filesize then
					return true
				end
			end,
			additional_vim_regex_highlighting = false,
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "gnn",
				node_incremental = "grn",
				scope_incremental = "grc",
				node_decremental = "grm",
			},
		},
		indent = {
			enable = false
		},
		autotag = {
			enable = true
		}
	})

	vim.api.nvim_create_autocmd('FileType', {
		pattern = { 'python', 'c', 'typescript', 'javascript' },
		callback = function() vim.treesitter.start() end,
	})

	require("nvim-autopairs").setup({
		disable_filetype = { "TelescopePrompt" }
	})

	require("nvim-ts-autotag").setup({})

	---@diagnostic disable-next-line
	require("Comment").setup({})
end

return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	dependencies = {
		"windwp/nvim-autopairs",
		"windwp/nvim-ts-autotag",
		"numToStr/Comment.nvim",
	},
	config = setup
}
