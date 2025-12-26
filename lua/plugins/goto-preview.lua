if not vim.g.jeff_enable_goto_preview then
  return {}
end

-- Leader 'p'
return {
  "rmagatti/goto-preview",
  dependencies = {
    "rmagatti/logger.nvim",
    "nvim-telescope/telescope.nvim",
  },
  event = "BufEnter",
  config = function()
    local gtp = require('goto-preview')
    gtp.setup({})

    vim.keymap.set('n', '<leader>pd', function()
      gtp.goto_preview_definition()
    end, { desc = "Preview definition" })
    vim.keymap.set('n', '<leader>ptd', function()
      gtp.goto_preview_type_definition()
    end, { desc = "Preview type definition" })
    vim.keymap.set('n', '<leader>pi', function()
      gtp.goto_preview_implementation()
    end, { desc = "Preview implementation" })
    vim.keymap.set('n', '<leader>pca', function()
      gtp.close_all_win()
    end, { desc = "Close all preview windows" })
    vim.keymap.set('n', '<leader>pr', function()
      gtp.goto_preview_references()
    end, { desc = "Preview references" })
  end,
}
