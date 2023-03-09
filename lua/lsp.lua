vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		vim.lsp.buf.format()
	end,
})

return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "williamboman/mason-lspconfig.nvim", "folke/neodev.nvim" },
		config = function()
			-- TODO Load neodev only for lua
			require("neodev").setup({
				library = {
					plugins = {
						"nvim-dap-ui",
						"mason",
						"mason-lspconfig",
						"mason-null-ls",
						"null-ls",
						"nvim-treesitter",
						"luasnips",
						"nvim-cmp",
					},
					types = true,
				},
			})
			local lspconfig = require("lspconfig")
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
		end,
	},

	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = { "jay-babu/mason-null-ls.nvim" },
		config = function()
			require("mason-null-ls").setup({ automatic_setup = true })
			require("null-ls").setup({})
			require("mason-null-ls").setup_handlers()
		end,
	},
}
