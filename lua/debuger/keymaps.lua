local dap = require'dap'
local dapui = require'dapui'

local map = vim.keymap.set


map("n", ";B", ":lua require'dap'.toggle_breakpoint()<CR>")
map("n", ";C", function()
    local cond = vim.fn.input("Condition:")
    dap.set_breakpoint(cond, "", "")
end)
map("n", ";L", function()
    local log = vim.fn.input("Log:")
    dap.set_breakpoint("", "", log)
end)

map("n", ";;", ":lua require'dap'.continue()<CR>")
map("n", ";j", ":lua require'dap'.step_over()<CR>")
map("n", ";i", ":lua require'dap'.step_into()<CR>")
map("n", ";o", ":lua require'dap'.step_out()<CR>")
map("n", ";T", function()
    dapui.close()
    dap.terminate()
end)
