vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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
	},

	-- Colorschemes
	"gruvbox-community/gruvbox",
	"Shatur/neovim-ayu",
	"catppuccin/nvim",
	"tomasiser/vim-code-dark",

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
	"rmagatti/alternate-toggler",
	"romgrk/barbar.nvim",
	"nvim-tree/nvim-tree.lua",
	"rhysd/clever-f.vim",
	require("neoclip-config"),

	-- TREESITTER
	"nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/nvim-treesitter-textobjects",
	"p00f/nvim-ts-rainbow",
	"windwp/nvim-autopairs",
	require("refactor-config"),

	-- LSP
	require("lsp"),

	-- Autocompletado
	require("cmp-config"),
	require("snippets"),

	-- Terminal
	"akinsho/toggleterm.nvim",

	-- Git
	"airblade/vim-gitgutter",

	-- Debugger
	"mfussenegger/nvim-dap",
	"rcarriga/nvim-dap-ui",
	"jay-babu/mason-nvim-dap.nvim",
	"theHamsta/nvim-dap-virtual-text",

	-- Org mode
	"nvim-neorg/neorg",
}

local opts = {}

require("lazy").setup(plugins, opts)

require("gral-configs")
require("gral-keymaps")
require("colorschemes")
require("toggleterm-config")
require("telescope-config")
require("treesitter-config")
require("barbar-config")
require("snippets")
require("tree-config")

require("lsp")
require("debuger")
