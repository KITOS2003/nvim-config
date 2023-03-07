local ls = require("luasnip")
local events = require("luasnip.util.events")

local map = vim.keymap.set

-- General configurations

ls.setup({
	update_events = { "TextChanged", "TextChangedI", "CursorMoved" },
})

-- Basic keymaps

map({ "i", "s" }, "<c-j>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })

map({ "i", "s" }, "<c-k>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

map({ "i", "s" }, "<c-l>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	else
		print("no choice active")
	end
end, { silent = true })

map({ "i", "s" }, "<c-h>", function()
	if ls.choice_active() then
		ls.change_choice(-1)
	else
		print("no choice active")
	end
end, { silent = true })

-- Snippets
require("snippets.python")
