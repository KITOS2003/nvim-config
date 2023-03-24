local env_query = [[
(generic_environment
    begin: (begin
        name: (curly_group_text
            text: (text)@beg)
    )
    end: (end
        name: (curly_group_text
            text: (text)@end)
    )
)@env
]]

local get_root = function(bufnr)
    local parser = vim.treesitter.get_parser(bufnr, "latex", {})
    local tree = parser:parse()[1]
    return tree:root()
end

-- TODO bytes??
local is_cursor_inside = function(cursor_row, cursor_col, row_start, row_end, col_start, col_end)
    if cursor_row > row_start and cursor_row < row_end then
        return true
    end
    if row_start == row_end then
        if cursor_col >= col_start and cursor_col <= col_end then
            return true
        else
            return false
        end
    end
    if cursor_row == row_start then
        if cursor_col >= col_start then
            return true
        else
            return false
        end
    end
    if cursor_row == row_end then
        if cursor_col <= row_end then
            return true
        else
            return false
        end
    end
end

local edit_match = function(query, match, edit_captures)
end

local create_textobj = function(lang, query_code, search_capture, edit_captures)
    local query = vim.treesitter.parse_query(lang, query_code)
    return function()
        local bufnr = vim.api.nvim_get_current_buf()
        local root = get_root(bufnr)
        local cursor_row, cursor_col = unpack(vim.api.nvim_win_get_cursor(0))
        -- Gather all matches into a table
        local matches = {}
        for _, match, _ in query:iter_matches(root, bufnr, 0, -1) do
            table.insert(matches, match)
        end
        -- First see if the cursor is inside a match, if so take the innermost one
        local previous_match_rows = 1000000
        local previous_match_columns = 1000000
        local match_on_cursor = nil
        for _, match in ipairs(matches) do
            for id, node in pairs(match) do
                if query.captures[id] == search_capture then
                    local row_start, col_start, row_end, col_end = node:range()
                    if is_cursor_inside(cursor_row, cursor_col, row_start, row_end, col_start, col_end) then
                        local node_rows = row_end - row_start
                        local node_cols = col_end - col_start
                        if node_rows < previous_match_rows then
                            match_on_cursor = match
                            previous_match_rows = node_rows
                            previous_match_columns = node_cols
                        elseif node_rows == previous_match_rows then
                            if node_cols < previous_match_columns then
                                match_on_cursor = match
                                previous_match_rows = node_rows
                                previous_match_columns = node_cols
                            end
                        end
                    end
                end
            end
        end
        if match_on_cursor then
            for id, node in pairs(match_on_cursor) do
                print(query.captures[id], node, node:range())
            end
            -- If not, take the first match after the cursor
        else
            for _, match in pairs(matches) do
                for id, node in pairs(match) do
                    if query.captures[id] == search_capture then
                        local row_start, col_start, _, _ = node:range()
                        if cursor_row > row_start then
                            goto continue
                        end
                        if cursor_row == row_start then
                        end
                    end
                end
                ::continue::
            end
        end
    end
end

TEXTOBJ_ENV = create_textobj("latex", env_query, "env", nil)
