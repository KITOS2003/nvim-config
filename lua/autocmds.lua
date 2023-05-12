local group = vim.api.nvim_create_augroup("Clear", { clear = true })

vim.api.nvim_create_autocmd("BufWritePre", {
    callback = function()
        vim.lsp.buf.format()
    end,
    group = group,
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
    end,
    group = group,
})
