local map = vim.keymap.set
local opts = { noremap = true, silent = true }

local beg_end = vim.treesitter.parse_query(
	"latex",
	[[
(generic_environment
  (begin
    name: (curly_group_text
            (text)@beg
            )
    )
  (end
    name: (curly_group_text
            (text)@end
            )
    )
)@parent
]]
)

local math_query = vim.treesitter.parse_query(
	"latex",
	[[
(inline_formula) @outer_math
(displayed_equation) @outer_math
]]
)

local get_root = function(bufnr)
	local parser = vim.treesitter.get_parser(bufnr, "latex", {})
	local tree = parser:parse()[1]
	return tree:root()
end

local select_range = function(line1, row1, line2, row2)
	local command = string.format("%dgg%d|v%dgg%d|", line1 + 1, row1 + 1, line2 + 1, row2)
	vim.cmd.normal(command)
end

function MATH_TEXTOBJ(type)
	return function()
		local bufnr = vim.api.nvim_get_current_buf()
		local root = get_root(bufnr)
		local cursor_row, cursor_col = unpack(vim.api.nvim_win_get_cursor(0))
		cursor_row = cursor_row - 1
		for id, node in math_query:iter_captures(root, bufnr, 0, -1) do
			local row1, col1, row2, col2 = node:range({ include_bytes = false })
			if cursor_row > row2 then
				goto continue
			end
			if cursor_row == row2 and cursor_col > col2 then
				goto continue
			end
			select_range(row1, col1, row2, col2)
			do
				return
			end
			::continue::
		end
	end
end

map({ "o", "x" }, "im", ":<C-u>lua MATH_TEXTOBJ('inner_math')()<CR>", opts)
map({ "o", "x" }, "am", ":<C-u>lua MATH_TEXTOBJ('outer_math')()<CR>", opts)

map({ "o", "x" }, "ie", "ib")
map({ "o", "x" }, "ae", "ab")
