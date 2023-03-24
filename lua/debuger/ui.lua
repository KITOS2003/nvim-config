local dap = require("dap")
local dapui = require("dapui")

local map = vim.keymap.set

dapui.setup({})

dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

-- Keymaps
map("n", "mu", function()
    dapui.toggle()
end)
