local map     = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd

vim.g.mapleader = ","

-- Source file
map("n", "<leader>so", vim.cmd.so)

-- Copying and pasting to and from clipboard
map({"n", "v"}, "y", '"+y')
map({"n", "v"}, "d", '"+d')
map({"n", "v"}, "p", '"+p')

-- Moving through visual lines only
map("n", "j", "gj")
map("n", "k", "gk")

-- Moving text around
map("n", "<A-Down>", ":m +1<CR>" )
map("n", "<A-Up>", ":m -2<CR>" )
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
map("n", "tt", ":tab new<CR>")
map("n", "<c-l>", "gt", { noremap = true })
map("n", "<c-h>", "gT", { noremap = true })
map("n", "t1", "1gt")
map("n", "t2", "2gt")
map("n", "t3", "3gt")
map("n", "t4", "4gt")
map("n", "t5", "5gt")
map("n", "t6", "6gt")
map("n", "t7", "7gt")
map("n", "t8", "8gt")
map("n", "t9", "9gt")

-- Filetype specific mappings
autocmd("FileType",
{
    pattern = "python",
    callback = function()
        vim.schedule(function()
            map("n", "<F1>", ":TermExec cmd='python %'<CR>")
        end)
    end,
})

autocmd("FileType",
{
    pattern = {"latex", "plaintex"},
    callback = function()
        vim.schedule(function()
            local filename = vim.fn.expand('%')
            local basename = string.sub(filename, 1, -4)
            map("n", "<F1>", string.format(":TermExec cmd='pdflatex {}; biber {}'<CR>"), {filename, basename})
            -- map("n", "<F2>", )
        end)
    end,
})

autocmd("FileType",
{
    pattern  = { "c", "cpp" },
    callback = function()
        vim.schedule(function()
            
        end)
    end
})
