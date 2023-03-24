return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"p00f/nvim-ts-rainbow",
		},
		config = function()
			local treesitter_conf = require("nvim-treesitter.configs")

			treesitter_conf.setup({
				ensure_installed = "all",
				ignore_install = { "phpdoc" },
				sync_install = false,
				highlight = {
					enable = true,
				},
				indent = {
					enable = false,
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "gnn",
						node_incremental = "<C-n>",
						scope_incremental = "<C-s>",
						node_decremental = "<C-b>",
					},
				},
				textobjects = {
					select = {
						enable = true,
						keymaps = {
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["al"] = "@loop.outer",
							["il"] = "@loop.inner",
							["a?"] = "@conditional.outer",
							["i?"] = "@conditional.inner",
							["ap"] = "@parameter.outer",
							["ip"] = "@parameter.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
							["ib"] = "@block.inner",
							["ab"] = "@block.outer",
							["it"] = "@frame.inner",
							["at"] = "@frame.outer",
							["is"] = "@statement.inner",
							["as"] = "@statement.outer",
							-- Only for latex
							["am"] = "@math.outer",
							["_eb"] = "@env_name.beg",
							["_ee"] = "@env_name.end",
						},
					},
					move = {
						enable = true,
						set_jumps = true,
						goto_next_start = {
							["<leader>gf"] = "@function.outer",
							["<leader>gl"] = "@loop.outer",
							["<leader>g?"] = "@conditional.outer",
							["<leader>gp"] = "@parameter.outer",
							["<leader>gc"] = "@class.outer",
						},
					},
				},
				rainbow = {
					enable = true,
					-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
					extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
					max_file_lines = nil, -- Do not enable for files with more than n lines, int
					-- colors = {}, -- table of hex strings
					-- termcolors = {} -- table of colour name strings
				},
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},
	"nvim-treesitter/nvim-treesitter-context",
}
