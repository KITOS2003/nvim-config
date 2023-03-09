return {
	"L3MON4D3/LuaSnip",
	config = function()
		local ls = require("luasnip")

		ls.setup({
			update_events = { "TextChanged", "TextChangedI", "CursorMoved" },
		})

		-- Snippets
		require("snippets.python")
	end,
}
