-- define your colorscheme here
-- the order of this array is the order they'll be applied. As soon as one is 
-- found the loop quits
local colorschemes = {
    "tokyonight",
    "monokai_pro",
}
for _, scheme in ipairs(colorschemes) do
    local is_ok, _ = pcall(vim.cmd, "colorscheme " .. scheme)
    if is_ok then
        return
    end
end

vim.notify("Could not find applicable color scheme", vim.log.levels.ERROR)

