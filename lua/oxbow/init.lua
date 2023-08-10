-- Create an object for the module.
-- All of the module's functions are associated with this object.
-- This object is returned when the module is called with 'require'.
local M = {}

function cflow(filename, start_function)
    -- Run the cflow command and store the output
    local command_string = 'cflow ' .. filename

    if start_function ~= nil then
        command_string = command_string .. ' --main ' .. start_function
    end

    local output_file = io.popen(command_string)
    local lines = {}
    for line in output_file:lines() do
        lines[#lines+1] = line
    end
    return lines
end

function write_lines_to_vertical_split(lines)
    -- Open a new vertical split
    vim.cmd('vsplit')
    local win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_win_set_buf(win, buf)

    -- Write the lines to the new buffer
    vim.api.nvim_buf_set_lines(buf, 0, 0, false, lines)
end

function M.run_file()
    -- Get the name of the current file
    local filename = vim.fn.expand('%:p')
    lines = cflow(filename)

    -- Write cflow output to a vertical split
    write_lines_to_vertical_split(lines)
end

function M.run_function() 
    -- Get the name of the current file
    local filename = vim.fn.expand('%:p')

    local word_under_cursor = vim.fn.expand('<cword>')

    lines = cflow(filename, word_under_cursor)

    -- Write cflow output to a vertical split
    write_lines_to_vertical_split(lines)
end

return M
