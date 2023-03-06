local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet

local map = vim.keymap.set

-- General configurations

ls.setup(
{
    update_events = {"TextChanged", "TextChangedI"}
})

-- Basic keymaps

map({"i", "s"}, "<c-j>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })

map({"i", "s"}, "<c-k>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })

map({"i", "s"}, "<c-l>", function()
    if ls.choice_active() then
        ls.change_choice(1)
    end
end, { silent = true })

map({"i", "s"}, "<c-h>", function()
    if ls.choice_active() then
        ls.change_choice(-1)
    end
end, { silent = true })

-- Snippets

ls.add_snippets("python",
{
    s("inp", {
        t'import numpy as np'
    }),
    s("iplt", {
        t'import matplotlib.pyplot as plt'
    }),
    s("icurv", {
        t'from scipy.optimize import curve_fit'
    }),
    s("ifft", {
        t'from scipy.fft import fft, fftfreq'
    }),
    s("imp", {
        c(1,
        {
            fmt([[
            import {}
            ]],
            {i(1, "library")}),
            fmt([[
            from {} import {}
            ]],
            {i(1, "library"), i(2, "thing")})
        })
    }),
})
