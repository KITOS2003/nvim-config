local set = vim.cmd.set
local autocmd = vim.api.nvim_create_autocmd

set("number relativenumber")
set("autoindent")
set("virtualedit=all")
set("belloff=all")
set("expandtab")
set("tabstop=4")
set("softtabstop=4")
set("shiftwidth=4")
set("splitright")
set("noshowmode")

-- Open files in new tabs

-- autocmd("BufAdd", {callback = function()
--     vim.cmd("wincmd T")
-- end})

-- Simple plugins
require('leap').add_default_mappings()
