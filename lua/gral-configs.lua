vim.cmd("set number relativenumber")
vim.cmd("set autoindent")
vim.cmd("set virtualedit=all")
vim.cmd("set belloff=all")
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.cmd("set splitright")
vim.cmd("set noshowmode")
vim.cmd("set undofile")
vim.cmd("silent !mkdir /tmp/neovim-undo-dir")
vim.cmd("set undodir=/tmp/neovim-undo-dir")
vim.cmd("set termguicolors")
vim.cmd("set colorcolumn=80")

vim.keymap.set("n", "<Up>", "<nop>")
vim.keymap.set("n", "<Down>", "<nop>")
vim.keymap.set("n", "<Left>", "<nop>")
vim.keymap.set("n", "<Right>", "<nop>")

-- vim.cmd("source ~/.config/nvim/vimscript/vimtex.vim")
