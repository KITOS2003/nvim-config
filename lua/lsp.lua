vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		vim.lsp.buf.format()
	end,
})

vim.diagnostic.config({ underline = false })

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
			-- Use internal formatting for bindings like gq.
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					vim.bo[args.buf].formatexpr = nil
				end,
			})

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
						"vim-arduino",
					},
					types = true,
				},
			})
			local lspconfig = require("lspconfig")
			require("mason-lspconfig").setup({ automatic_setup = true })
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
				["texlab"] = function()
					local executable = "zathura"
					local args = {
						"--synctex-editor-command",
						[[nvim-texlabconfig -file '%{input}' -line %{line}]],
						"--synctex-forward",
						"%l:1:%f",
						"%p",
					}
					lspconfig.texlab.setup({
						settings = {
							texlab = {
								build = {
									isContinuous = true,
								},
								formatterLineLength = 80,
								forwardSearch = {
									executable = executable,
									args = args,
								},
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
	{
		"f3fora/nvim-texlabconfig",
		ft = { "tex", "plaintex" },
		build = "go build",
		config = function()
			require("texlabconfig").setup({
				cache_activate = true,
				cache_filetypes = { "tex", "bib" },
				cache_root = vim.fn.stdpath("cache"),
				reverse_search_start_cmd = function()
					return true
				end,
				reverse_search_edit_cmd = vim.cmd.edit,
				reverse_search_end_cmd = function()
					return true
				end,
				file_permission_mode = 438,
			})
		end,
	},
}
