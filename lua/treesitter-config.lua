local treesitter_conf = require("nvim-treesitter.configs")

treesitter_conf.setup({
	ensure_installed = "all",
	ignore_install = { "phpdoc" },
	sync_install = "false",
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
				["af"] = "@function.auter",
				["if"] = "@function.inner",
				["al"] = "@loop.auter",
				["il"] = "@loop.inner",
				["a?"] = "@conditional.auter",
				["i?"] = "@conditional.inner",
				["ap"] = "@parameter.auter",
				["ip"] = "@parameter.inner",
				["ac"] = "@class.auter",
				["ic"] = "@class.inner",
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

-- Autopairs

require("nvim-autopairs").setup({})
