local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd

local opts = { noremap = true, silent = true }

vim.g.mapleader = ","

-- Source file
map("n", "<leader>so", vim.cmd.so)

-- Copying and pasting to and from clipboard
map({ "n", "v" }, "y", '"+y')
map({ "n", "v" }, "d", '"+d')
map({ "n", "v" }, "p", '"+p')

-- Moving through visual lines only
map("n", "j", "gj")
map("n", "k", "gk")

-- Moving text around
map("n", "<A-Down>", ":m +1<CR>")
map("n", "<A-Up>", ":m -2<CR>")
map("n", "<A-Left>", "dlhhp")
map("n", "<A-Right>", "dlp")
map("v", "<A-Down>", "djhpgvjojo")
map("v", "<A-Up>", "dkhpgvkoko")
map("v", "<A-Left>", "dhhpgvhoho")
map("v", "<A-Right>", "dpgvlolo")
map("x", "J", ":move '>+1<CR>gv-gv", { silent = true })
map("x", "K", ":move '<-2<CR>gv-gv", { silent = true })
map("v", ">", ">gv")
map("v", "<", "<gv")

-- Search and replace
map("n", "-", ":let @/=''<CR>")
map("n", "<leader>r", ":%s///g<left><left>")
map("x", "<leader>r", ":s///g<left><left>")
map("n", "n", "nzz")

-- Tabs
map("n", "tt", ":badd ")
map("n", "th", "<Cmd>BufferPrevious<CR>", opts)
map("n", "tl", "<Cmd>BufferNext<CR>", opts)
map("n", "tk", "<Cmd>BufferMovePrevious<CR>", opts)
map("n", "tj", "<Cmd>BufferMoveNext<CR>", opts)
map("n", "t1", "<Cmd>BufferGoto 1<CR>", opts)
map("n", "t2", "<Cmd>BufferGoto 2<CR>", opts)
map("n", "t3", "<Cmd>BufferGoto 3<CR>", opts)
map("n", "t4", "<Cmd>BufferGoto 4<CR>", opts)
map("n", "t5", "<Cmd>BufferGoto 5<CR>", opts)
map("n", "t6", "<Cmd>BufferGoto 6<CR>", opts)
map("n", "t7", "<Cmd>BufferGoto 7<CR>", opts)
map("n", "t8", "<Cmd>BufferGoto 8<CR>", opts)
map("n", "t9", "<Cmd>BufferGoto 9<CR>", opts)
map("n", "t0", "<Cmd>BufferLast<CR>", opts)
map("n", "tp", "<Cmd>BufferPin<CR>", opts)
map("n", "tc", "<Cmd>BufferClose<CR>", opts)

-- LSP

local lspf = vim.lsp.buf

map("n", "ñd", lspf.definition, opts)
map("n", "ñD", lspf.declaration, opts)
map("n", "ñi", lspf.implementation, opts)
map("n", "ñ?", lspf.hover, opts)
map("n", "ñw", lspf.workspace_symbol, opts)
map("n", "ñr", lspf.references, opts)
map("n", "ñt", lspf.type_definition, opts)
map("n", "ñR", lspf.rename, opts)

-- Snippets

map({ "i", "s" }, "<c-j>", function()
    if require("luasnip").expand_or_jumpable() then
        require("luasnip").expand_or_jump()
    end
end, { silent = true })

map({ "i", "s" }, "<c-k>", function()
    if require("luasnip").jumpable(-1) then
        require("luasnip").jump(-1)
    end
end, { silent = true })

map({ "i", "s" }, "<c-l>", function()
    if require("luasnip").choice_active() then
        require("luasnip").change_choice(1)
    else
        print("no choice active")
    end
end, { silent = true })

map({ "i", "s" }, "<c-h>", function()
    if require("luasnip").choice_active() then
        require("luasnip").change_choice(-1)
    else
        print("no choice active")
    end
end, { silent = true })

-- Small plugins

map("n", "<C-s>", ":ToggleAlternate<CR>")

-- Filetype specific mappings
autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.schedule(function()
            map("n", "<F1>", ":TermExec cmd='python %'<CR>")
        end)
    end,
})

autocmd("FileType", {
    pattern = { "tex", "plaintex" },
    callback = function()
        vim.schedule(function()
            local filename = vim.fn.expand("%")
            local basename = string.sub(filename, 1, -5)
            map("n", "<F1>", string.format(":TermExec cmd='pdflatex %s; biber %s'<CR>", filename, basename))
            map(
                "n",
                "<F10>",
                string.format(":TermExec cmd='nohup zathura %s > /dev/null & disown ; exit'<CR>", filename)
            )
        end)
    end,
})

autocmd("FileType", {
    pattern = { "c", "cpp" },
    callback = function()
        vim.schedule(function()
        end)
    end,
})
