-- define common options
local opts = {
    noremap = true,      -- non-recursive
    silent = true,       -- do not show message
}

-----------------
-- Normal mode --
-----------------
-- Set 'signature_help' to Ctrl-Shift-K
vim.keymap.set('n', '<C-S-k>', vim.lsp.buf.signature_help, { noremap = true, silent = true, desc = 'Show LSP signature help' })

-- Hint: see `:h vim.map.set()`
-- Better window navigation
vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
vim.keymap.set('n', '<C-l>', '<C-w>l', opts)

-- Resize with arrows
-- delta: 2 lines
vim.keymap.set('n', '<C-Up>', ':resize -2<CR>', opts)
vim.keymap.set('n', '<C-Down>', ':resize +2<CR>', opts)
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', opts)
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-----------------
-- Visual mode --
-----------------

-- Hint: start visual mode with the same area as the previous area and the same mode
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

----------------
-- Telescope --
----------------
vim.keymap.set('n', '<leader>ff', function()
    require('telescope.builtin').find_files()
end, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', function()
    require('telescope.builtin').live_grep()
end, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', function()
    require('telescope.builtin').buffers()
end, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', function()
    require('telescope.builtin').help_tags()
end, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>fs', function()
    require('telescope.builtin').lsp_document_symbols()
end, { desc = 'Telescope find symbols' })

----------------
-- Tests --
----------------
vim.keymap.set('n', '<leader>tn', function()
    require('nvim-test').run("nearest")
end, { desc = 'Run nearest test' })

