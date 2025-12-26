if not vim.g.jeff_enable_trouble then
  return {}
end

return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    focus = true,
    modes = {
      diagnostics = {
        mode = "diagnostics",
        preview = {
          type = "split",
          relative = "win",
          position = "right",
          size = 0.5,
        },
        groups = {
          { "filename", format = "{file_icon} {basename:Title} {count}" },
        }
      }
    },
    icons = {
      indent = {
        middle = " ",
        last = " ",
        top = " ",
        ws = "|  ",
      }
    }
  },
  init = function()
    vim.keymap.set('n', '<leader>oe', ':Trouble diagnostics<CR>', { desc = "Show Trouble diagnostics" })
    vim.keymap.set('n', '<leader>ce', ':Trouble close<CR>', { desc = "Close Trouble diagnostics" })
  end
}
