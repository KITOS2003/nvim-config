local tree = require("nvim-tree")
local map = vim.keymap.set

tree.setup({
}) -- END_DEFAULT_OPTS

map("n", "<CR>", ":NvimTreeToggle<CR>")
