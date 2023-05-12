require 'debuger.keymaps'
require 'debuger.ui'

require("mason-nvim-dap").setup
{
    ensure_installed = { 'python', 'c' },
    automatic_setup = true,
    handlers = {},
}
require 'nvim-dap-virtual-text'.setup {}
