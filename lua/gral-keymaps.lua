local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd

local opts = { noremap = true, silent = true }

vim.g.mapleader = ","

-- Insert exit
map("i", "jk", "<Esc>")

-- Source file
map("n", "<leader>so", vim.cmd.so)

-- Copying and pasting to and from clipboard
map({ "n", "v" }, "y", '"+y')
map({ "n", "v" }, "d", '"+d')
map({ "n", "v" }, "p", '"+p')

-- Movements
map("n", "j", "gj")
map("n", "k", "gk")
map("n", "gC", ":lua require('neogen').generate()<CR>")

-- Moving text around
map("n", "<A-Down>", ":m +1<CR>")
map("n", "<A-Up>", ":m -2<CR>")
map("n", "<A-Left>", "dlhhp")
map("n", "<A-Right>", "dlp")
map("v", "<A-Up>", "dkhpgvkoko")
map("v", "<A-Down>", "djhpgvjojo")
map("v", "<A-Left>", "dhhpgvhoho")
map("v", "<A-Right>", "dpgvlolo")
map("x", "J", ":move '>+1<CR>gv-gv")
map("x", "K", ":move '<-2<CR>gv-gv")
map("v", ">", ">gv")
map("v", "<", "<gv")

-- Search and replace
map("n", "-", ":let @/=''<CR>")
map("n", "<leader>r", ":%s///g<left><left>")
map("x", "<leader>r", ":s///g<left><left>")

-- Cursor centering after some actions
map("n", "n", "nzz")
map("n", "N", "Nzz")
map("n", "u", "uzz", opts)
map("n", "<C-r>", "<C-r>zz", opts)
map("n", "cgn", "nzzcgn")
map("n", "<C-u>", "<C-u>zz", opts)
map("n", "<C-d>", "<C-d>zz", opts)

-- Improved visual mode experience
map("v", "A", ":normal A")
map("v", "I", ":normal I")
map("v", "N", ":normal ")

-- Tabs
map("n", "tt", ":badd ")
map("n", "th", "<Cmd>BufferPrevious<CR>")
map("n", "tl", "<Cmd>BufferNext<CR>")
map("n", "tk", "<Cmd>BufferMovePrevious<CR>")
map("n", "tj", "<Cmd>BufferMoveNext<CR>")
map("n", "tp", "<Cmd>BufferPin<CR>")
map("n", "tq", "<Cmd>BufferClose<CR>")
map("n", "tQ", "<Cmd>BufferClose<CR>")
map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>")
map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>")
map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>")
map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>")
map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>")
map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>")
map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>")
map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>")
map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>")
map("n", "<A-0>", "<Cmd>BufferLast<CR>")

-- Splits
map("n", "<A-j>", "<C-w>j")
map("n", "<A-k>", "<C-w>k")
map("n", "<A-l>", "<C-w>l")
map("n", "<A-h>", "<C-w>h")

map("n", "<A-J>", ":split<CR><C-w>j")
map("n", "<A-K>", ":split<CR>")
map("n", "<A-L>", ":vsplit<CR>")
map("n", "<A-H>", ":vsplit<CR><C-w>h")

-- LSP

local lspf = vim.lsp.buf

map("n", "ñd", lspf.definition)
map("n", "ñD", lspf.declaration)
map("n", "ñi", lspf.implementation)
map("n", "ñ?", lspf.hover)
map("n", "ñw", lspf.workspace_symbol)
map("n", "ñr", lspf.references)
map("n", "ñt", lspf.type_definition)
map("n", "ñR", lspf.rename)

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

-- Improved increment/decrement
vim.keymap.set("n", "<C-a>", require("dial.map").inc_normal(), { noremap = true })
vim.keymap.set("n", "<C-x>", require("dial.map").dec_normal(), { noremap = true })
vim.keymap.set("v", "<C-a>", require("dial.map").inc_visual(), { noremap = true })
vim.keymap.set("v", "<C-x>", require("dial.map").dec_visual(), { noremap = true })
vim.keymap.set("v", "g<C-a>", require("dial.map").inc_gvisual(), { noremap = true })
vim.keymap.set("v", "g<C-x>", require("dial.map").dec_gvisual(), { noremap = true })

-- Undo tree

map("n", "U", ":lua require('undotree').toggle()<CR>")

-- Telescope
local builtin = require("telescope.builtin")

map("n", "<leader>/", builtin.current_buffer_fuzzy_find)
map("n", "<leader>gr", builtin.live_grep)
map("n", "<leader>f", builtin.find_files)
map("n", "<leader>F", builtin.oldfiles)
map("n", "<leader>C", builtin.commands)
map("n", "<leader>c", builtin.command_history)
map("n", "<leader>k", ":Telescope keymaps<CR>")
map("n", "<leader>y", require("telescope").extensions.neoclip.default)
map("n", "<leader>q", require("telescope").extensions.macroscope.default)

-- Git (preceeded by ')
map("n", "'d", ":Gitsigns diffthis<CR>", opts)
map("n", "'a", ":Gitsigns stage_hunk<CR>", opts)
map("n", "'A", ":Gitsigns stage_buffer<CR>", opts)
map("n", "'n", ":Gitsigns next_hunk<CR>", opts)
map("n", "'N", ":Gitsigns prev_hunk<CR>", opts)
map("n", "'?", ":Gitsigns preview_hunk<CR>", opts)
map("n", "'b", ":Gitsigns blame_line<CR>", opts)

-- Filetype specific mappings
autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.schedule(function()
            map("n", "<F1>", ":TermExec cmd='python %'<CR>")
            map("n", "<F2>", ":TermExec cmd='python -i %'<CR>")
            map({ "n", "v", "x" }, "<leader><leader>t", ":normal A   #type:ignore<CR>")
        end)
    end,
})

autocmd("FileType", {
    pattern = { "tex", "plaintex" },
    callback = function()
        vim.schedule(function()
            local group = vim.api.nvim_create_augroup("LatexGroup", { clear = true })
            autocmd("BufWritePost", {
                callback = function()
                    vim.cmd("TexlabBuild")
                    vim.cmd("TexlabForward")
                end,
                group = group,
            })
            map("n", "zn", "]s", opts)
            map("n", "<F1>", ":TexlabBuild<CR>", opts)
            map("n", "<leader>gv", ":TexlabForward<CR>", opts)
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
