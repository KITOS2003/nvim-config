local ls = require("luasnip")
local ts = vim.treesitter

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

------------- STUFF FOR THE "imp" SNIPPET -------------

local lib_aliases = {
	["numpy"] = "np",
	["matplotlib.pyplot"] = "plt",
	["pandas"] = "pd",
	["seaborn"] = "sb",
	["unumpy"] = "unp",
	["uncertainties.unumpy"] = "unp",
	["pyvisa"] = "pv",
}

local commonly_used_funcs = {
	-- TODO this
	["seaborn"] = { "set_theme" },
	["scipy.optimize"] = { "curve_fit" },
	["scipy.signal"] = { "find_peaks" },
	["scipy.fft"] = { "fft, fftfreq" },
	["scipy.integrate"] = { "quad", "odeint" },
}

local generate_alias = function(index, input_index)
	return d(index, function(args)
		local alias = lib_aliases[args[1][1]]
		if alias == nil then
			local parts = vim.split(args[1][1], ".", { plain = true })
			alias = string.sub(parts[#parts], 1, 3)
		end
		return sn(nil, { i(1, alias) })
	end, { input_index })
end

local get_common_funcs = function(args)
	local common_funcs = commonly_used_funcs[args[1][1]]
	if common_funcs ~= nil then
		return sn(nil, c(1, { i(nil, "hello"), i(nil, "world") }))
	else
		return sn(nil, i(1, "thing"))
	end
end

------------- STUFF FOR THE "def" SNIPPET -------------

-- returns true if the cursor is directly inside a class or right on top
-- of a method definition
-- returns false if the cursor is outside of a class or in a block of code inside a method
local is_inside_class = function()
	local row, column = unpack(vim.api.nvim_win_get_cursor(0))
	local node = ts.get_node_at_pos(0, row - 1, column, {})
	if node == nil then
		return false
	elseif node:parent() == nil then
		return false
	end
	if node:type() == "class_definition" or node:parent():type() == "class_definition" then
		return true
	else
		return false
	end
end

local add_comma = function(args)
	local user_input = args[1][1]
	if args[2][1] ~= "self" then
		return ""
	end
	if user_input == "" or user_input[1] == "," then
		return ""
	else
		return ", "
	end
end
------------- STUFF FOR THE "class" SNIPPET ------------

local add_comma_class = function(args)
	local user_input = args[1][1]
	if user_input == "" or user_input[1] == "," then
		return ""
	else
		return ", "
	end
end

local possible_classes_choice = function(args) -- TODO LSP integration
	return sn(nil, i(1, ""))
end

------------- STUFF FOR THE "for" SNIPPET -------------

local iteration_variable_fn = function() --TODO treesitter integration
	return sn(nil, { i(1, "x") })
end

local index_fn = function() --TODO treesitter integration
	return sn(nil, { i(1, "i") })
end

---------------------- SNIPPETS -----------------------

return {
	add_snippets = function()
		ls.add_snippets("python", {
			s("pr", { --TODO regular expression trigger
				t("print("),
				c(1, {
					sn(nil, {
						t('f"'),
						i(1, ""),
						t('"'),
					}),
					sn(nil, {
						t('f"{'),
						i(1, ""),
						t(' = }"'),
					}),
					i(nil, ""),
				}),
				t({ ")", "" }),
				i(0, ""),
			}),
			-- import snippet
			s("imp", {
				c(1, {
					-- import x as y
					fmt(
						[[
                    import {}{}
                    ]],
						{
							r(1, "library"),
							c(2, {
								sn(nil, {
									t(" as "),
									generate_alias(1, ai[1][1][1]),
								}),
								t(""),
							}),
						}
					),
					-- from x import y
					fmt(
						[[
                    from {} import {}
                    ]],
						{
							r(1, "library"),
							c(2, {
								r(nil, "thing"),
								sn(nil, {
									r(1, "thing"),
									t(" as "),
									generate_alias(2, ai[1][2][2][2][1]),
								}),
							}),
						}
					),
				}),
			}, {
				stored = {
					["library"] = i(nil, "module"),
					["thing"] = d(nil, get_common_funcs, { ai[1][1][1] }),
				},
			}),
			-- Function definition snippet
			s("def", {
				t("def "),
				i(1, "funcntion"),
				t("("),
				sn(2, {
					extras.partial(function()
						if is_inside_class() then
							return "self"
						end
					end),
				}),
				f(add_comma, { 3, 2 }),
				i(3, ""),
				t(")"),
				c(4, {
					sn(nil, {
						t({ ":", "    " }),
						r(1, "body"),
					}),
					sn(nil, {
						t(" -> "),
						i(1, "Type"),
						t({ ":", "    " }),
						r(2, "body"),
					}),
				}),
			}, {
				stored = {
					["body"] = i(nil, ""),
				},
			}),
			-- class definition snippet
			s("class", {
				t("class "),
				c(1, {
					r(nil, "Name"),
					sn(nil, {
						r(1, "Name"),
						t("("),
						d(2, possible_classes_choice),
						t(")"),
					}),
				}),
				t({ ":", "    " }),
				t("def __init__(self"),
				f(add_comma_class, { 3 }),
				i(2, ""),
				t({ "):", "        " }),
			}, {
				stored = {
					["name"] = i(nil, "Name"),
				},
			}),
			s("try", {
				t({ "try:", "   " }),
				i(1, ""),
				t({ "", "except:", "   " }),
				i(2, ""),
				c(3, {
					sn(nil, {
						t({ "", "" }),
						i(1, ""),
					}),
					sn(nil, {
						t({ "", "else:", "   " }),
						i(1, ""),
						c(2, {
							sn(nil, {
								t({ "", "" }),
								i(1, ""),
							}),
							sn(nil, {
								t({ "", "finally:", "   " }),
								i(1, ""),
								t("", ""),
								i(0, ""),
							}),
						}),
					}),
					sn(nil, {
						t({ "", "finally:", "   " }),
						i(1, ""),
						t("", ""),
						i(0, ""),
					}),
				}),
			}),
			-- for loop snippet
			s("for", {
				t("for "),
				c(1, {
					sn(nil, {
						r(1, "iteration_variable"),
						t(" in "),
						r(2, "iterable"),
					}),
					sn(nil, {
						r(1, "index"),
						t(", "),
						r(2, "iteration_variable"),
						t(" in enumerate("),
						r(3, "iterable"),
						t(")"),
					}),
					sn(nil, {
						r(1, "index"),
						t(" in range("),
						i(2, "n"),
						t(")"),
					}),
				}),
				t({ ":", "    " }),
				i(0, ""),
			}, {
				stored = {
					["iteration_variable"] = d(nil, iteration_variable_fn),
					["index"] = d(nil, index_fn),
					["iterable"] = i(nil, "iterable"),
				},
			}),
		})
	end,
}
