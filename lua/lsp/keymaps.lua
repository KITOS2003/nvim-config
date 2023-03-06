local map = vim.keymap.set
local lspf = vim.lsp.buf

local opts = { noremap = true }

map("n", "<leader>ld", lspf.definition, opts)
map("n", "<leader>lD", lspf.declaration, opts)
map("n", "<leader>li", lspf.implementation, opts)
map("n", "<leader>l?", lspf.document_symbol, opts)
map("n", "<leader>lw", lspf.workspace_symbol, opts)
map("n", "<leader>lr", lspf.references, opts)
map("n", "<leader>lt", lspf.type_definition, opts)
map("n", "<leader>lR", lspf.rename, opts)
