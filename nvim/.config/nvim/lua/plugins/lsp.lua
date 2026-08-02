local function setup()
	require("lazydev").setup()

	local lsp = vim.lsp
	lsp.config("pyright", {})
	lsp.enable("pyright")

	lsp.config("lua_ls", {})
	lsp.enable("lua_ls")
	-- lspconfig["tailwindcss"] = {
	-- 	filetypes = { "typescriptreact", "javascriptreact", "vue", "svelte", "html" }
	-- }
	-- lspconfig["lua_ls"] = {}
	-- lspconfig["hls"] = {}
	-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
	-- 	callback = function(opts)
	-- 		if vim.bo[opts.buf].filetype == "haskell" then
	-- 			local bo = vim.bo
	-- 			bo.expandtab = true
	-- 			bo.smartindent = true
	-- 			bo.tabstop = 2
	-- 			bo.shiftwidth = 2
	-- 		end
	-- 	end
	-- })
	--
	-- lspconfig["intelephense"] = {}
	lsp.enable("clangd")
	-- lspconfig["gopls"] = {}
	-- lspconfig["pyright"] = {
	-- 	settings = {
	-- 		python = {
	-- 			analysis = {
	-- 				typeCheckingMode = "standard"
	-- 			}
	-- 		}
	-- 	}
	-- }
	-- lspconfig["jdtls"] = {
	-- 	root_dir = function()
	-- 		local dir = vim.fs.dirname(vim.fs.find({ '.git' }, { upward = true })[1])
	-- 		if dir == nil then
	-- 			dir = vim.fn.getcwd()
	-- 		end
	-- 		return dir
	-- 	end
	-- }
	-- lspconfig["vuels"] = {}
	-- lspconfig["metals"] = {
	-- 	filetypes = { "scala" },
	-- 	init_options = {
	-- 		statusBarProvider = 'off',
	-- 		isHttpEnabled = true,
	-- 		compilerOptions = {
	-- 			snippetAutoIndent = false,
	-- 		},
	-- 	},
	-- 	root_dir = function()
	-- 		return vim.fn.getcwd()
	-- 	end
	-- }
	--
	-- lspconfig["asm_lsp"] = {
	-- 	root_dir = function()
	-- 		return vim.fn.getcwd()
	-- 	end
	-- }
	--
	-- --Enable (broadcasting) snippet capability for completion
	-- local capabilities = vim.lsp.protocol.make_client_capabilities()
	-- capabilities.textDocument.completion.completionItem.snippetSupport = true
	--
	-- lspconfig["cssls"] = {
	-- 	capabilities = capabilities,
	-- }
	--
	
	local tsCapabilities = vim.lsp.protocol.make_client_capabilities();
	tsCapabilities.textDocument.completion.completionItem.snippetSupport = true
	lsp.config("ts_ls", {
		capabilities=tsCapabilities,
		cmd = function(dispatchers)
			return vim.lsp.rpc.start({ "tsc", '--lsp', '--stdio' }, dispatchers)
		end,
	})
	lsp.enable("ts_ls")

	-- local htmlCapabilities = vim.lsp.protocol.make_client_capabilities()
	-- htmlCapabilities.textDocument.completion.completionItem.snippetSupport = true
	-- lspconfig["html"] = { capabilities = htmlCapabilities }
	--
	-- local rustCapabilities = vim.lsp.protocol.make_client_capabilities()
	-- rustCapabilities.textDocument.completion.completionItem.snippetSupport = true
	-- rustCapabilities.textDocument.completion.completionItem.resolveSupport = {
	-- 	properties = { 'additionalTextEdits' }
	-- }
	-- lspconfig["rust_analyzer"] = {
	-- 	capabilities = rustCapabilities,
	-- }
	--
	-- lspconfig["jsonls"] = {
	-- 	settings = {
	-- 		json = {
	-- 			schemas = require('schemastore').json.schemas(),
	-- 			validate = { enable = true }
	-- 		},
	-- 	},
	-- 	capabilities = jsonCapabilities,
	-- }

	local jsonCapabilities = vim.lsp.protocol.make_client_capabilities()
	jsonCapabilities.textDocument.completion.completionItem.snippetSupport = true
	lsp.config("jsonls", {
		settings = {
			json = {
				schemas = require('schemastore').json.schemas(),
				validate = { enable = true },
			},
		},
		capabilities = jsonCapabilities,
	})
	lsp.enable("jsonls")


	local yamlSchema = require('schemastore').yaml.schemas()
	yamlSchema["kubernetes"] = "*.yaml"
	lsp.config("yamlls", {
		settings = {
			yaml = {
				schemas = yamlSchema
			},
		},
	})
	lsp.enable("yamlls")
end

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		-- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gD', '<cmd>Telescope lsp_type_definitions<CR>', opts)
		vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', opts)
		vim.keymap.set('n', 'gp', "<C-t>", opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<CR>', opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<space>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)

		local severity = vim.diagnostic.severity
		vim.diagnostic.config({
			signs = {
				text = {
					[severity.ERROR] = "",
					[severity.WARN] = "",
					[severity.HINT] = "",
					[severity.INFO] = "",
				}
			}
		})

		vim.api.nvim_set_keymap('n', '<space>do', '<cmd>lua vim.diagnostic.open_float()<CR>',
			{ noremap = true, silent = true })
		vim.api.nvim_set_keymap('n', '<space>d[', '<cmd>lua vim.diagnostic.goto_prev()<CR>',
			{ noremap = true, silent = true })
		vim.api.nvim_set_keymap('n', '<space>d]', '<cmd>lua vim.diagnostic.goto_next()<CR>',
			{ noremap = true, silent = true })
	end,
})

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"folke/lazydev.nvim",
		"b0o/schemastore.nvim",
	},
	config = setup,
}
