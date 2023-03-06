local lspconfig = require("lspconfig")

local on_attach = function()end

lspconfig.clangd.setup
{
    on_attach = on_attach,
    flags = {},
    settings = {}
}
