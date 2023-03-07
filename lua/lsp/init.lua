local lspconfig = require("lspconfig")

require("mason").setup()
require("mason-lspconfig").setup({
	automatic_setup = true,
	ensure_installed = { "lua_ls" },
})

require("mason-lspconfig").setup_handlers({
	function(server_name)
		lspconfig[server_name].setup({})
	end,
	["pylsp"] = function()
		lspconfig.pylsp.setup({
			settings = {
				pylsp = {
					plugins = {
						pycodestyle = { enabled = false },
					},
				},
			},
		})
	end,
	["ltex"] = function()
		lspconfig.ltex.setup({
			settings = {
				ltex = {
					language = "es",
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
