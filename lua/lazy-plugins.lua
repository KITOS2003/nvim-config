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

local dashboard_config =
{
    theme = 'hyper',
    config =
    {
        week_header =
        {
            enable = true
        }
    }
}

local plugins =
{
	-- Colorschemes
	'gruvbox-community/gruvbox',
    'Shatur/neovim-ayu',
    "catppuccin/nvim",

	-- Misc
	'tpope/vim-surround',
	'tpope/vim-repeat',
    'https://tpope.io/vim/commentary.git',
    'haya14busa/vim-asterisk',
    'vzze/calculator.nvim',
    'nvim-lualine/lualine.nvim',
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope.nvim', tag = '0.1.1' },
    'ggandor/leap.nvim',
    'nvim-tree/nvim-web-devicons',
    {
      'glepnir/dashboard-nvim',
      event = 'VimEnter',
      config = function()
        require('dashboard').setup(dashboard_config)
      end,
      dependencies = { {'nvim-tree/nvim-web-devicons'}}
    },

    -- TREESITTER
    'nvim-treesitter/nvim-treesitter',
    'nvim-treesitter/nvim-treesitter-textobjects',
    'p00f/nvim-ts-rainbow',
    'windwp/nvim-autopairs',

    -- LSP
    'williamboman/mason.nvim',
    'neovim/nvim-lspconfig',
    'williamboman/mason-lspconfig.nvim',
    'folke/neodev.nvim',

    -- Autocompletado
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/nvim-cmp',
    'L3MON4D3/LuaSnip',

    -- Terminal
    "akinsho/toggleterm.nvim",

    -- Git
    'airblade/vim-gitgutter',

    -- Debugger
    'mfussenegger/nvim-dap',
    'rcarriga/nvim-dap-ui',
    'mfussenegger/nvim-dap-python',
    'jay-babu/mason-nvim-dap.nvim',
}

local opts = {}

require'lazy'.setup(plugins, opts)


