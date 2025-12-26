-- https://github.com/OXY2DEV/markview.nvim
if not vim.g.jeff_enable_markview then
  return {}
end

return {
  "OXY2DEV/markview.nvim",
  lazy = false,
  dependencies = { "saghen/blink.cmp" },
  opts = {
    preview = {
      filetypes = { "markdown", "codecompanion" },
      ignore_buftypes = {},
    },
  },
  config = function()
    require("markview").setup()

    vim.keymap.set('n', '<leader>tm', ':MarkviewToggle<CR>', { desc = "Toggle Markview" })
  end,
}
