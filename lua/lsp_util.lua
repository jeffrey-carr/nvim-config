local M = {}

-- Safely close the hover window
function M.close_hover()
    local hover_win = vim.api.nvim_get_current_win()
    if vim.api.nvim_win_is_valid(hover_win) then
        pcall(vim.api.nvim_win_close, hover_win, true)
    end
end

return M

