local map = vim.keymap.set

local builtin = require'telescope.builtin'

map("n", "<leader>/", builtin.current_buffer_fuzzy_find )
map("n", "<leader>g/", builtin.live_grep )
map("n", "<leader><leader>f/", builtin.find_files )
map("n", "<leader>c/", builtin.commands )
map("n", "<leader>h/", builtin.command_history )
map("n", "<leader>H/", builtin.oldfiles )
