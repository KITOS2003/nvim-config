require'debuger.keymaps'
require'debuger.ui'

require("mason-nvim-dap").setup
{
    ensure_installed = { 'python', 'c' },
    automatic_setup = true
}
require'mason-nvim-dap'.setup_handlers {}
require'nvim-dap-virtual-text'.setup {}
