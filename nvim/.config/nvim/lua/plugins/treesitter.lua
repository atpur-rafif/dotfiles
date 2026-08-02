local function setup()
	require("nvim-treesitter").setup({})

	vim.api.nvim_create_autocmd('FileType', {
		pattern = { '*' },
		callback = function(args)
			local ft = vim.bo[args.buf].filetype
			local lang = vim.treesitter.language.get_lang(ft)
			if lang == nil then return end
			local treesitter = require("nvim-treesitter")

			if not vim.tbl_contains(treesitter.get_installed(), lang) then
				return
			end

			vim.treesitter.language.add(lang)
			vim.treesitter.start(args.buf, lang)
		end,
	})

	require("nvim-autopairs").setup({ disable_filetype = { "TelescopePrompt" } })

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
