local dap = require("dap")
local dapui = require("dapui")

local map = vim.keymap.set

map("n", "mb", ":lua require'dap'.toggle_breakpoint()<CR>")
map("n", "mc", function()
	local cond = vim.fn.input("Condition:")
	dap.set_breakpoint(cond, "", "")
end)
map("n", "ml", function()
	local log = vim.fn.input("Log:")
	dap.set_breakpoint("", "", log)
end)

map("n", "mm", ":lua require'dap'.continue()<CR>")
map("n", "mj", ":lua require'dap'.step_over()<CR>")
map("n", "mi", ":lua require'dap'.step_into()<CR>")
map("n", "mo", ":lua require'dap'.step_out()<CR>")
map("n", "mq", function()
	dapui.close()
	dap.terminate()
end)
