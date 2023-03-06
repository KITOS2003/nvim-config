require'neodev'.setup
{
    library = { plugins = { "nvim-dap-ui" }, types = true },
}

local lspconfig = require'lspconfig'
require'mason'.setup()
require'mason-lspconfig'.setup
{
    ensure_installed = { "lua_ls" }

}

local on_attach = function()
end

require'mason-lspconfig'.setup_handlers
{
    function(server_name)
        lspconfig[server_name].setup {}
    end,
    ['pylsp'] = function()
        lspconfig.pylsp.setup
        {
            on_attach = on_attach,
            settings =
            {
                pylsp =
                {
                    plugins =
                    {
                        flake8 = { enabled = false },
                        pycodestyle = { enabled = false }
                    }
                }
            }
        }
    end
}

require("lsp.python")
require("lsp.clang")
require("lsp.keymaps")
require("lsp.cmp")
