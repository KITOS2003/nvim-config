vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- https://github.com/yutkat/my-neovim-pluginlist

--  ╔══════════════════════════════════════════════════════════╗
--  ║                           TODO                           ║
--  ║                "gbprod/substitute.nvim",                 ║
--  ║                  "saecki/crates.nvim",                   ║
--  ║               "simrat39/rust-tools.nvim",                ║
--  ║               "Civitasv/cmake-tools.nvim",               ║
--  ║                 "RRethy/vim-illuminate",                 ║
--  ║                 'stevearc/dressing.nvim'                 ║
--  ║                  'mattn/libcallex-vim'                   ║
--  ║            'bytesnake/vim-graphical-preview'             ║
--  ║                   'stevearc/oil.nvim',                   ║
--  ║                 "zbirenbaum/copilot.lua"                 ║
--  ║                                                          ║
--  ╚══════════════════════════════════════════════════════════╝
-- LAZY:

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
	{
		"lewis6991/impatient.nvim",
		lazy = false,
		priority = 10000,
		config = function()
			require("impatient")
		end,
	},

	-- Colorschemes
	"gruvbox-community/gruvbox",
	"Shatur/neovim-ayu",
	"catppuccin/nvim",
	"Mofiqul/vscode.nvim",
	"rebelot/kanagawa.nvim",

	-- Misc
	"tpope/vim-surround",
	"tpope/vim-repeat",
	"https://tpope.io/vim/commentary.git",
	"haya14busa/vim-asterisk",
	"nvim-lualine/lualine.nvim",
	"nvim-lua/plenary.nvim",
	{ "nvim-telescope/telescope.nvim", tag = "0.1.1" },
	"nvim-tree/nvim-web-devicons",
	"lukas-reineke/indent-blankline.nvim",
	-- "monaqa/dial.nvim",
	"romgrk/barbar.nvim",
	"nvim-tree/nvim-tree.lua",
	"rhysd/clever-f.vim",
	"norcalli/nvim-colorizer.lua",
	"LudoPinelli/comment-box.nvim",
	-- {
	-- 	"jiaoshijie/undotree",
	-- 	requirements = { "nvim-lua/plenary.nvim" },
	-- 	config = function()
	-- 		require("undotree").setup({
	-- 		})
	-- 	end,
	-- },
	{
		"smjonas/live-command.nvim",
		config = function()
			require("live-command").setup({
				commands = {
					Norm = { cmd = "norm" },
					G = { cmd = "g" },
				},
			})
		end,
	},
	{
		"danymat/neogen",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = function()
			require("neogen").setup({ snippet_engine = "luasnip" })
		end,
	},
	require("neoclip-config"),

	-- treesitter
	require("treesitter-config"),
	require("refactor-config"),
	"nvim-treesitter/playground",

	-- LSP
	require("lsp"),

	-- Autocompletado
	require("cmp-config"),
	require("snippets"),

	-- Terminal
	"akinsho/toggleterm.nvim",

	-- Debugger
	"mfussenegger/nvim-dap",
	"rcarriga/nvim-dap-ui",
	"jay-babu/mason-nvim-dap.nvim",
	"theHamsta/nvim-dap-virtual-text",

	-- Python specific
	-- {
	-- 	"luk400/vim-jukit", -- TODO
	-- config = function()
	-- end
	-- },

	-- { -- TODO Arduino
	-- 	"stevearc/vim-arduino",
	-- 	config = function()
	-- 		vim.g.arduino_dir = "~/.arduino15"
	-- 	end,
	-- },
	-- 'edKotinsky/Arduino.nvim',

	-- GIT
	require("git"),
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = {
				"markdown",
			}
		end,
		ft = {
			"markdown",
		},
	},

	-- External
	{
		"glacambre/firenvim",
		-- Lazy load firenvim
		-- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
		cond = not not vim.g.started_by_firenvim,
		build = function()
			require("lazy").load({ plugins = "firenvim", wait = true })
			vim.fn["firenvim#install"](0)
		end,
	},
}

local opts = {}

require("lazy").setup(plugins, opts)

-- TODO refactor this
require("gral-configs")
require("gral-keymaps")
require("colorschemes")
require("toggleterm-config")
require("telescope-config")
require("barbar-config")
require("tree-config")

require("debuger")

require("autocmds")

-- require("latex-plugin")
