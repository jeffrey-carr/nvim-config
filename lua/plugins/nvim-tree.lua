if not vim.g.jeff_enable_nvim_tree then
  return {}
end

return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    require('nvim-tree').setup({
      hijack_directories = { enable = false },
      update_focused_file = { enable = true },
      view = {
        relativenumber = true,
        width = 55,
      },
    })
    local api = require('nvim-tree.api')

    vim.keymap.set('n', '<leader>to', ':NvimTreeFindFile<CR>', { desc = "Open directory tree" })
    vim.keymap.set('n', '<leader>tcl', ':NvimTreeClose<CR>', { desc = "Close directory tree" })
    vim.keymap.set('n', '<leader>ta', function()
      api.fs.create()
    end, { desc = "Add file or directory" })
    vim.keymap.set('n', '<leader>tcpa', function()
      api.fs.copy.absolute_path()
    end, { desc = "Copy absolute filepath" })
    vim.keymap.set('n', '<leader>tcpr', function()
      api.fs.copy.relative_path()
    end, { desc = "Copy relative filepath" })
    vim.keymap.set('n', '<leader>tcnb', function()
      api.fs.copy.basename()
    end, { desc = "Copy file basename" })
    vim.keymap.set('n', '<leader>tcnf', function()
      api.fs.copy.filename()
    end, { desc = "Copy file name" })
    vim.keymap.set('n', '<leader>ti', function()
      api.node.show_info_popup()
    end, { desc = "Open Info" })
    vim.keymap.set('n', '<leader>tba', function()
      api.marks.toggle()
    end, { desc = "Toggle bookmark" })
    vim.keymap.set('n', '<leader>tbf', function()
      api.tree.toggle_no_bookmark_filter()
    end, { desc = "Filter bookmarks" })
    vim.keymap.set('n', '<leader>ts', function()
      api.tree.search_node()
    end, { desc = "Search" })
  end
}
