require("neodev").setup({ library = { plugins = { "nvim-dap-ui" }, types = true } })

require("mason").setup()
require("mason-lspconfig").setup({
	automatic_setup = true,
	ensure_installed = { "lua_ls" },
})

require("mason-lspconfig").setup_handlers({
	function(server_name)
		require("lspconfig")[server_name].setup({})
	end,
	["pylsp"] = function()
		require("lspconfig").pylsp.setup({
			pylsp = {
				pylsp = {
					plugins = {
						pycodestyle = { enabled = false },
						flake8 = { enabled = false },
					},
				},
			},
		})
	end,
})

require("mason-null-ls").setup({ automatic_setup = true })

require("null-ls").setup({})

require("mason-null-ls").setup_handlers()

vim.api.nvim_create_autocmd("BufWritePost", {
	callback = function()
		vim.lsp.buf.format()
	end,
})

require("lsp.keymaps")
require("lsp.cmp")
