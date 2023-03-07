local map = vim.keymap.set
local lspf = vim.lsp.buf

local opts = { noremap = true }

map("n", "ñd", lspf.definition, opts)
map("n", "ñD", lspf.declaration, opts)
map("n", "ñi", lspf.implementation, opts)
map("n", "ñ?", lspf.hover, opts)
map("n", "ñw", lspf.workspace_symbol, opts)
map("n", "ñr", lspf.references, opts)
map("n", "ñt", lspf.type_definition, opts)
map("n", "ñR", lspf.rename, opts)
