vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- TODO
-- "gbprod/substitute.nvim",
-- "saecki/crates.nvim",
-- "simrat39/rust-tools.nvim",
-- "Civitasv/cmake-tools.nvim",
-- "RRethy/vim-illuminate",

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
    "monaqa/dial.nvim",
    "romgrk/barbar.nvim",
    "nvim-tree/nvim-tree.lua",
    "rhysd/clever-f.vim",
    "norcalli/nvim-colorizer.lua",
    "LudoPinelli/comment-box.nvim",
    -- "eandrju/cellular-automaton.nvim", -- Lol
    {
        "jiaoshijie/undotree",
        requirements = { "nvim-lua/plenary.nvim" },
        config = function()
            require("undotree").setup({
                float_diff = true,
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

    -- { -- TODO
    -- 	"stevearc/vim-arduino",
    -- 	config = function()
    -- 		vim.g.arduino_dir = "~/.arduino15"
    -- 	end,
    -- },
    "ThePrimeagen/vim-be-good",

    -- GIT
    require("git"),
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

-- require("latex-plugin")
