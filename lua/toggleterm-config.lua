local toggleterm = require("toggleterm")

toggleterm.setup({
	open_mapping = "<C-t>",
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "tab",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {},
})

function _G.set_terminal_keymaps()
	local opts = { noremap = true }
	vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-w>w]], opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
